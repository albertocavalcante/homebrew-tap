import assert from "node:assert/strict";
import { spawnSync } from "node:child_process";
import fs from "node:fs";
import os from "node:os";
import path from "node:path";
import test from "node:test";
import { fileURLToPath } from "node:url";

const script =
  process.env.GVY_AUDIT_SCRIPT ||
  fileURLToPath(new URL("./audit-formulas.sh", import.meta.url));

function fixture(t, mode = "success") {
  const root = fs.mkdtempSync(path.join(os.tmpdir(), "formula audit "));
  t.after(() => fs.rmSync(root, { recursive: true, force: true }));
  fs.mkdirSync(path.join(root, "bin"));
  for (const name of ["first", "second"])
    fs.writeFileSync(
      path.join(root, `${name}.rb`),
      "class Example < Formula; end\n",
    );
  const fakeBrew = path.join(root, "bin", "brew");
  fs.writeFileSync(
    fakeBrew,
    `#!/usr/bin/env node
const fs = require("node:fs");
const path = require("node:path");
const args = process.argv.slice(2);
const root = process.env.GVY_AUDIT_TEST_ROOT;
fs.appendFileSync(path.join(root, "calls"), JSON.stringify(args) + "\\n");
const mode = process.env.GVY_AUDIT_TEST_MODE;
if (args[0] === "tap-new") {
  fs.mkdirSync(path.join(root, "tap", "Formula"), { recursive: true });
  if (mode === "collision") process.exit(73);
} else if (args[0] === "--repository") {
  if (mode === "repository") process.exit(71);
  console.log(path.join(root, "tap"));
} else if (args[0] === "help" && mode === "legacy") {
  process.exit(1);
} else if (args[0] === "trust" && mode === "trust") {
  process.exit(72);
} else if (args[0] === "audit" && args.at(-1).endsWith("/first") && mode.startsWith("audit")) {
  console.error("fixture audit failure");
  process.exit(42);
} else if (args[0] === "untap") {
  if (mode.endsWith("untap")) { console.error("fixture untap failure"); process.exit(73); }
  fs.rmSync(path.join(root, "tap"), { recursive: true });
} else if (args[0] === "untrust" && mode === "untrust") {
  console.error("fixture untrust failure");
  process.exit(74);
}
`,
  );
  fs.chmodSync(fakeBrew, 0o755);
  return {
    root,
    run: (...names) =>
      spawnSync(
        "/bin/sh",
        [script, ...names.map((name) => path.join(root, name))],
        {
          encoding: "utf8",
          env: {
            ...process.env,
            PATH: `${root}/bin:${process.env.PATH}`,
            GVY_AUDIT_TEST_ROOT: root,
            GVY_AUDIT_TEST_MODE: mode,
          },
        },
      ),
    calls: () =>
      fs.existsSync(path.join(root, "calls"))
        ? fs
            .readFileSync(path.join(root, "calls"), "utf8")
            .trim()
            .split("\n")
            .map((line) => JSON.parse(line))
        : [],
  };
}

test("audits multiple formula paths with spaces and cleans up owned state", (t) => {
  const f = fixture(t);
  const result = f.run("first.rb", "second.rb");
  assert.equal(result.status, 0, result.stderr);
  assert.equal(f.calls().filter((args) => args[0] === "audit").length, 2);
  assert.equal(f.calls().filter((args) => args[0] === "untrust").length, 2);
  assert.equal(f.calls().filter((args) => args[0] === "untap").length, 1);
  assert.equal(fs.existsSync(path.join(f.root, "tap")), false);
});

test("a tap collision never removes or trusts an unowned tap", (t) => {
  const f = fixture(t, "collision");
  assert.equal(f.run("first.rb").status, 73);
  assert.equal(
    f.calls().some((args) => ["trust", "untrust", "untap"].includes(args[0])),
    false,
  );
  assert.equal(fs.existsSync(path.join(f.root, "tap")), true);
});

test("retains audit failure while auditing the remaining formulas and cleaning up", (t) => {
  const f = fixture(t, "audit");
  assert.equal(f.run("first.rb", "second.rb").status, 42);
  assert.equal(f.calls().filter((args) => args[0] === "audit").length, 2);
  assert.equal(f.calls().filter((args) => args[0] === "untap").length, 1);
});

for (const [mode, status] of [
  ["repository", 71],
  ["trust", 72],
]) {
  test(`${mode} failure preserves its status and removes the owned tap`, (t) => {
    const f = fixture(t, mode);
    assert.equal(f.run("first.rb").status, status);
    assert.equal(f.calls().filter((args) => args[0] === "untap").length, 1);
  });
}

test("older Homebrew needs no trust commands", (t) => {
  const f = fixture(t, "legacy");
  assert.equal(f.run("first.rb").status, 0);
  assert.equal(
    f.calls().some((args) => ["trust", "untrust"].includes(args[0])),
    false,
  );
});

for (const mode of ["untap", "untrust"]) {
  test(`a ${mode} cleanup failure is visible and cannot report success`, (t) => {
    const f = fixture(t, mode);
    const result = f.run("first.rb");
    assert.notEqual(result.status, 0);
    assert.match(result.stderr, new RegExp(`${mode}.*fail|fail.*${mode}`, "i"));
  });
}

test("cleanup failure does not overwrite the original audit failure", (t) => {
  const f = fixture(t, "audit-untap");
  const result = f.run("first.rb");
  assert.equal(result.status, 42);
  assert.match(result.stderr, /untap/);
});

for (const names of [[], ["missing.rb"], ["first.rb", "missing.rb"]]) {
  test(`rejects invalid inputs before creating a tap: ${JSON.stringify(names)}`, (t) => {
    const f = fixture(t);
    assert.equal(f.run(...names).status, 2);
    assert.deepEqual(f.calls(), []);
  });
}
