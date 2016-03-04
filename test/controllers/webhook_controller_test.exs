defmodule Bigben.Travis.TotalTimeCalculator do
  def calculate_total_time(_), do: 1
end

defmodule Bigben.WebhookControllerTest do
  use Bigben.ConnCase
  alias Bigben.Build

  test "POST /webhook with a passing build, creates an entry", %{conn: conn} do
    payload = ~s/{
      "status":0,
      "started_at":"2016-02-23T01:20:00Z",
      "finished_at":"2016-02-23T01:21:00Z",
      "branch":"master"
    }/
    params = %{ "payload" => payload }

    conn = post conn, "/webhook", params

    assert text_response(conn, 200)

    last_build = Repo.one(from b in Build, preload: [:branch])

    assert last_build.branch.name == "master"
    assert stringify(last_build.started_at) == "2016-02-23T01:20:00.000Z"
    assert stringify(last_build.finished_at) == "2016-02-23T01:21:00.000Z"
  end

  test "POST /webhook with a failing build, does not create an entry", %{conn: conn} do
    payload = ~s/{
      "status":1,
      "started_at":"2016-02-23T01:20:00Z",
      "finished_at":"2016-02-23T01:21:00Z",
      "branch":"master"
    }/
    params = %{ "payload" => payload }

    conn = post conn, "/webhook", params

    assert text_response(conn, 200)

    assert Repo.one(Build) == nil
  end

  defp stringify(datetime) do
    datetime |> Timex.DateFormat.format!("{ISOz}")
  end
end
