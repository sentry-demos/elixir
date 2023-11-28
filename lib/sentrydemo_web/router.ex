defmodule SentrydemoWeb.Router do
  use SentrydemoWeb, :router

  pipeline :browser do
    plug :accepts, ["html", "json"]
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
    get "/handled", DemoController, :handled
    get "/unhandled", DemoController, :unhandled
    get "/message", DemoController, :message
    get "/exception", DemoController, :exception
    get "/task_crash", DemoController, :task_crash
    get "/genserver_crash", DemoController, :genserver_crash
  end

  scope "/api", SentrydemoWeb do
    pipe_through :api

    post "/process_order", ProcessOrderController, :index
  end
end
