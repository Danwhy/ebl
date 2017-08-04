defmodule Ebl.Router do
  use Ebl.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Ebl do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  scope "/data", Ebl do
    pipe_through :api

    get "/", DataController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", Ebl do
  #   pipe_through :api
  # end
end
