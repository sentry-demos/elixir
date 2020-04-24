defmodule SentrydemoWeb.Router do
  use SentrydemoWeb, :router
  use Plug.ErrorHandler
  use Sentry.Plug

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

  scope "/", SentrydemoWeb do
    pipe_through :browser

    get "/", PageController, :index
    get "/handled", HandledController, :index
    get "/unhandled", UnhandledController, :index
    post "/process_order", ProcessOrderController, :index
  end
end

  # Other scopes may use custom stacks.
#   scope "/api/v1", SentrydemoWeb do
#     pipe_through :api
#     get "/handled", HandledController, :index
#     get "/unhandled", UnhandledController, :index
#     post "/process_order", ProcessOrderController, :index
#   end
# end

