defmodule Bigben.Travis.ApiToken do
  import HTTPoison
  import Bigben.Travis.UrlBuilder

  def get_token do
    start

    post(auth_url, auth_body, auth_headers) |> extract
  end

  defp extract({:ok, response}) do
    parsed_body = response.body |> Poison.decode!
    parsed_body["access_token"]
  end

  defp auth_headers do
    [{"Content-Type", "application/json"}]
  end

  defp auth_body do
    ~s/{ "github_token": "#{api_key}" }/
  end

  defp api_key do
    System.get_env("GITHUB_API_TOKEN")
  end
end
