#!/bin/sh
set -eu

if [ "$#" -eq 0 ]; then
  echo "Usage: tools/audit-formulas.sh Formula/name.rb [...]" >&2
  exit 2
fi
for formula_file; do
  formula_name=${formula_file##*/}
  formula_name=${formula_name%.rb}
  case "$formula_file" in
  *.rb) ;;
  *)
    echo "Expected a Ruby formula: $formula_file" >&2
    exit 2
    ;;
  esac
  case "$formula_name" in
  '' | *[!a-z0-9@+._-]*)
    echo "Invalid formula name: $formula_name" >&2
    exit 2
    ;;
  esac
  if [ ! -f "$formula_file" ] || [ ! -r "$formula_file" ]; then
    echo "Formula is not a readable file: $formula_file" >&2
    exit 2
  fi
done

audit_tap="lefthook/audit-$$"
audit_tap_created=0
trusted_formulas=""
cleanup() {
  cleanup_exit_code=$1
  trap - 0
  if [ "$audit_tap_created" -eq 1 ]; then
    # Validated formula names cannot contain whitespace.
    for trusted_formula in $trusted_formulas; do
      if ! brew untrust --formula "$trusted_formula"; then
        echo "Audit cleanup failed: brew untrust --formula $trusted_formula" >&2
        if [ "$cleanup_exit_code" -eq 0 ]; then cleanup_exit_code=1; fi
      fi
    done
    if ! brew untap "$audit_tap"; then
      echo "Audit cleanup failed: brew untap $audit_tap" >&2
      if [ "$cleanup_exit_code" -eq 0 ]; then cleanup_exit_code=1; fi
    fi
  fi
  exit "$cleanup_exit_code"
}
trap 'cleanup "$?"' 0
trap 'exit 129' HUP
trap 'exit 130' INT
trap 'exit 143' TERM

brew tap-new --no-git "$audit_tap"
audit_tap_created=1
audit_formula_dir="$(brew --repository "$audit_tap")/Formula"
supports_trust=0
if brew help trust >/dev/null 2>&1 && brew help untrust >/dev/null 2>&1; then
  supports_trust=1
fi

audit_exit_code=0
for formula_file; do
  formula_name=${formula_file##*/}
  formula_name=${formula_name%.rb}
  case "$formula_file" in /*) ;; *) formula_file="./$formula_file" ;; esac
  cp "$formula_file" "$audit_formula_dir/$formula_name.rb"
  audit_formula="$audit_tap/$formula_name"
  if [ "$supports_trust" -eq 1 ]; then
    trusted_formulas="$trusted_formulas $audit_formula"
    brew trust --formula "$audit_formula"
  fi
  if brew audit --formula "$audit_formula"; then
    :
  else
    result=$?
    if [ "$audit_exit_code" -eq 0 ]; then audit_exit_code=$result; fi
  fi
done
cleanup "$audit_exit_code"
