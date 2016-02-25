defmodule Bigben.Travis.TotalTimeCalculator do
  import HTTPoison
  import Bigben.Travis.UrlBuilder

  def calculate_total_time(travis_id) do
    auth_token = Bigben.Travis.ApiToken.get_token

    find_jobs(travis_id, auth_token) |> calculate_total_times
  end

  def find_jobs(travis_build_id, auth_token) do
    start
    travis_build_id
    |> build_url
    |> get(travis_headers(auth_token))
    |> extract_jobs
  end

  def calculate_total_times(jobs) do
    Enum.reduce jobs, 0, fn(job, sum) ->
      calculate_time(job) + sum
    end
  end

  def calculate_time(job) do
    job
    |> build_time_tuple
    |> Bigben.Build.calculate_time_difference
  end

  defp build_time_tuple(job) do
    { :ok, started_at } = job["started_at"] |> parse_time
    { :ok, finished_at } = job["finished_at"] |> parse_time
    %{started_at: started_at, finished_at: finished_at}
  end

  defp parse_time(time_string) do
    Timex.Ecto.DateTime.cast time_string
  end

  defp extract_jobs({:ok, response}) do
    response.body
    |> Poison.decode!
    |> Map.get("jobs")
  end

  defp travis_headers(auth_token) do
    [
      { "Content-Type", "application/json" },
      { "Accept", "application/vnd.travis-ci.2+json" },
      { "User-Agent", "MyClient/1.0.0" },
      { "Host", "api.travis-ci.com" },
      { "Authorization", "token #{auth_token}" },
    ]
  end
end
