defmodule Helpers.Sentry do
  def before_send(event) do
    tags = Map.merge(event.tags, %{se: "tda"})
    if Enum.any?(tags, fn {_, handled} -> handled == true end) do
      IO.puts("handled is true, so the exception isn't sent to Sentry.")
      nil
    else
      %Sentry.Event{event | tags: tags}
    end
  end
end
