defmodule Checkout do
  def update_inventory(cart, inventory, tool) do
    if inventory[tool] < cart[tool] do
      raise "Not enough inventory for #{tool}"
    else
      IO.puts "Success: #{tool} was purchased, remaining stock is #{inventory[tool]-1}"
      inventory[tool] - 1
    end
  end

  def process_order(cart, inventory) do
    new_inv = Enum.map(cart, fn ({k, _v}) -> {k, Checkout.update_inventory(cart, inventory, k)} end)
    Enum.into(new_inv, %{})
  end
end

defmodule SentrydemoWeb.ProcessOrderController do
  use SentrydemoWeb, :controller
  plug :set_metadata

  def set_metadata(conn, _opts) do
    Sentry.Context.set_tags_context(%{customerType: "enterprise"})
    Sentry.Context.set_user_context(%{email: "jane.doe@sentry.io"})
    Sentry.Context.set_extra_context(%{details: "checkout flow error"})

    Enum.each(0..5, fn _ ->
      Sentry.Context.add_breadcrumb(%{
        type: :debug,
        category: "db",
        message: "SELECT",
        data: %{query: "SELECT * FROM products WHERE tool = %"}
      })
    end)

    conn
  end

  def index(conn, _params) do
    inventory = %{"wrench" => 5, "nails" => 2, "hammer" => 4}
    inventory = Checkout.process_order(conn.params, inventory)

    conn |> json(inventory)
  end
end
