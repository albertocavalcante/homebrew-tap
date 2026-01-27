# frozen_string_literal: true

# Custom download strategy for private GitHub repository release assets.
# Requires HOMEBREW_GITHUB_API_TOKEN environment variable to be set.
#
# Usage in formula:
#   require_relative "../lib/private_strategy"
#   url "https://github.com/owner/repo/releases/download/v1.0.0/file.tar.gz",
#       using: GitHubPrivateRepositoryReleaseDownloadStrategy

require "download_strategy"

# Strategy for downloading from private GitHub repositories
class GitHubPrivateRepositoryDownloadStrategy < CurlDownloadStrategy
  require "utils/formatter"
  require "utils/github"

  def initialize(url, name, version, **meta)
    super
    parse_url_pattern
    set_github_token
  end

  def parse_url_pattern
    url_pattern = %r{https://github.com/([^/]+)/([^/]+)/(\S+)}
    unless @url =~ url_pattern
      raise CurlDownloadStrategyError, "Invalid url pattern for GitHub Repository."
    end

    _, @owner, @repo, @filepath = *@url.match(url_pattern)
  end

  def download_url
    "https://#{@github_token}@github.com/#{@owner}/#{@repo}/#{@filepath}"
  end

  private

  def _fetch(url:, resolved_url:, timeout:)
    curl_download download_url, to: temporary_path, timeout: timeout
  end

  def set_github_token
    @github_token = ENV["HOMEBREW_GITHUB_API_TOKEN"]
    unless @github_token
      raise CurlDownloadStrategyError, "Environmental variable HOMEBREW_GITHUB_API_TOKEN is required."
    end
  end
end

# Strategy for downloading release assets from private GitHub repositories
class GitHubPrivateRepositoryReleaseDownloadStrategy < GitHubPrivateRepositoryDownloadStrategy
  def initialize(url, name, version, **meta)
    super
  end

  def parse_url_pattern
    url_pattern = %r{https://github.com/([^/]+)/([^/]+)/releases/download/([^/]+)/(\S+)}
    unless @url =~ url_pattern
      raise CurlDownloadStrategyError, "Invalid url pattern for GitHub Release."
    end

    _, @owner, @repo, @tag, @filename = *@url.match(url_pattern)
  end

  def download_url
    "https://api.github.com/repos/#{@owner}/#{@repo}/releases/assets/#{asset_id}"
  end

  private

  def _fetch(url:, resolved_url:, timeout:)
    curl_download download_url,
                  "--header", "Authorization: token #{@github_token}",
                  "--header", "Accept: application/octet-stream",
                  to: temporary_path,
                  timeout: timeout
  end

  def asset_id
    @asset_id ||= resolve_asset_id
  end

  def resolve_asset_id
    release_metadata = fetch_release_metadata
    assets = release_metadata["assets"].select { |a| a["name"] == @filename }
    raise CurlDownloadStrategyError, "Asset file not found: #{@filename}" if assets.empty?

    assets.first["id"]
  end

  def fetch_release_metadata
    release_url = "https://api.github.com/repos/#{@owner}/#{@repo}/releases/tags/#{@tag}"
    output, = curl_output(
      "--header", "Authorization: token #{@github_token}",
      "--header", "Accept: application/vnd.github.v3+json",
      release_url
    )
    JSON.parse(output)
  end
end
