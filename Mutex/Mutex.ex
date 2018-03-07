defmodule Cell do
  def new() do
     spawn_link(fn -> cell(:open) end)
  end

  defp cell(state) do
    receive do
      {:get, from} ->
        send(from, {:ok, state})
        cell(state)
      {:set, value, from} ->
        send(from, :ok)
        cell(value)
    end
  end
end
