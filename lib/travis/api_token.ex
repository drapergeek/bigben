defmodule Bigben.Travis.ApiToken do
  import HTTPoison
  import Bigben.Travis.UrlBuilder

  def get_token do
    start

    post(auth_url, auth_body, auth_headers)
    |> extract
  end

  def extract({:ok, response}) do
    parsed_body = response.body |> Poison.decode!
    parsed_body["access_token"]
  end

  def auth_headers do
    [
      {"Content-Type", "application/json"},
      {"Accept", "application/vnd.travis-ci.2+json"},
      {"User-Agent", "MyClient/1.0.0"},
    ]
  end

  def auth_body do
    ~s/{ "github_token": "#{api_key}" }/
  end

  def api_key do
    System.get_env("GITHUB_API_TOKEN")
  end
end
