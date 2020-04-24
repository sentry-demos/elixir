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
    new_inv = Enum.map(inventory, fn ({k, _v}) -> {k, Checkout.update_inventory(cart, inventory, k)} end)
    Enum.into(new_inv, %{})
  end
end

defmodule SentrydemoWeb.ProcessOrderController do
    use SentrydemoWeb, :controller

    def index(conn, _params) do
      inventory = %{"wrench" => 1, "nails" => 1, "hammer" => 1}

      {:ok, body, conn} = read_body(conn)
      {:ok, parsed} = Poison.decode(body)
      IO.inspect parsed

      inventory = Checkout.process_order(parsed, inventory)
      IO.inspect inventory
      conn
      |> send_resp(200, Poison.encode!(inventory))
    end
  end
