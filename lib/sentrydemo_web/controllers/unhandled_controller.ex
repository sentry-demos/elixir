defmodule SentrydemoWeb.UnhandledController do
  use SentrydemoWeb, :controller

  def index(_conn, _params) do
    map = %{}
    map.non_existing_key
  end
end
