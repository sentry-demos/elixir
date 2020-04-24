defmodule SentrydemoWeb.PageController do
  use SentrydemoWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
