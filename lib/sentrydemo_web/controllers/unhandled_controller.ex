defmodule SentrydemoWeb.UnhandledController do
    use SentrydemoWeb, :controller
    @dialyzer {:noreturn_function, g: 0}

    def index(_conn, _params) do
        map = %{}
        map.non_existing_key
    end
  end
