defmodule Bigben.WebhookController do
  use Bigben.Web, :controller
  require Logger

  def create(conn, params = %{ "payload" => %{"status" => 0 }}) do
    Bigben.BuildStatusUpdater.update(params["payload"])
    text conn, "Success"
  end

  def create(conn, params) do
    text conn, "Failing Builds are not needed here"
  end
end
