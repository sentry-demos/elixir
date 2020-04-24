defmodule SentrydemoWeb.HandledController do
    use SentrydemoWeb, :controller

    def index(conn, _params) do
        msg = %{"Error" => "A handled error occurred."}
        conn
        |> send_resp(500, Poison.encode!(msg))
        |> halt
        raise "#{msg["Error"]}"
    end
  end
