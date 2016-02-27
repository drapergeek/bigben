defmodule Bigben.WebhookController do
  use Bigben.Web, :controller
  require Logger

  def create(conn, params) do
    case get_status(params) do
      0 ->
        Bigben.BuildStatusUpdater.update(params["payload"])
      _ ->
        text conn, "Failing Builds are not needed here"
    end
  end

  defp get_status(params) do
    payload = params["payload"] |> Poison.decode!
    IO.inspect payload["status"]
  end
end
