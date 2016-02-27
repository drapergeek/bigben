defmodule Bigben.Travis.UrlBuilder do
  def auth_url do
    travis_api_url <> "/auth/github"
  end

  def build_url(id) do
    "#{travis_api_url}/repos/#{repo}/builds/#{id}"
  end

  def host do
    System.get_env("TRAVIS_HOST")
  end

  def travis_api_url do
    System.get_env("TRAVIS_API_URL")
  end

  def repo do
    System.get_env("REPO")
  end
end
