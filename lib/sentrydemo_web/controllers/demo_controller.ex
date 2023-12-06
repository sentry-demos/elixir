defmodule SentrydemoWeb.DemoController do
  use SentrydemoWeb, :controller

  def unhandled(_conn, _opts) do
    map = %{}
    map.non_existing_key
  end

  def handled(conn, _opts) do
    msg = %{"Error" => "A handled error occurred."}

    conn
    |> send_resp(500, Jason.encode!(msg))
    |> halt

    Sentry.Context.set_tags_context(%{status_code: 500})
    Sentry.Context.set_tags_context(%{is_handled: true})

    raise "#{msg["Error"]}"
  end

  def message(conn, _opts) do
    msg = "Something went horribly wrong."

    Sentry.capture_message(msg)

    conn |> text(msg)
  end

  def exception(conn, _opts) do
    try do
      1 / 0
    rescue
      exception ->
        Sentry.Context.set_tags_context(%{is_handled: true})
        Sentry.capture_exception(exception, stacktrace: __STACKTRACE__)
        conn |> text(Exception.message(exception))
    end
  end

  def task_crash(conn, _opts) do
    Task.start(fn ->
      Sentry.Context.set_tags_context(%{is_handled: true})
      raise "Task Error"
    end)

    conn |> text("task crashed")
  end

  def genserver_crash(conn, _opts) do
    Helpers.GenServer.crash
    conn |> text("genserver crashed")
  end
end
