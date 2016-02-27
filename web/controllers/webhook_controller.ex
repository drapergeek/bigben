defmodule Bigben.WebhookController do
  use Bigben.Web, :controller
  require Logger

  def create(conn, params) do
    json_params = params["payload"] |> Poison.decode!
    case json_params["status"] do
      0 ->
        Bigben.BuildStatusUpdater.update(json_params)
        text conn, "Success"
      _ ->
        text conn, "Failing Builds are not needed here"
    end
  end
end
