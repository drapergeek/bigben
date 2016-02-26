defmodule Bigben.Router do
  use Bigben.Web, :router
  use Honeybadger.Plug

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["html"]
  end

  scope "/", Bigben do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  scope "/", Bigben do
    post "/webhook", WebhookController, :create
  end
end
