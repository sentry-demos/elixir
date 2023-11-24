defmodule Helpers.Sentry do
  def before_send(event) do
    tags = Map.merge(event.tags, %{se: "tda"})
    %Sentry.Event{event | tags: tags}
  end
end
