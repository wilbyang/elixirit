defmodule Demo3.PoWServer do
  use GenServer

  # Client API

  def start_link(target_difficulty) do
    GenServer.start_link(__MODULE__, target_difficulty, name: __MODULE__)
  end

  def solve_puzzle(input) do
    GenServer.call(__MODULE__, {:solve, input})
  end

  # Server Callbacks

  @impl true
  def init(target_difficulty) do
    {:ok, target_difficulty}
  end

  @impl true
  def handle_call({:solve, input}, _from, target_difficulty) do
    {nonce, hash} = find_valid_nonce(input, target_difficulty)
    {:reply, {nonce, hash}, target_difficulty}
  end

  # Helper Functions

  defp find_valid_nonce(input, target_difficulty) do
    Stream.iterate(0, &(&1 + 1)) # Start from 0 and increment
    |> Stream.map(fn nonce -> {nonce, calculate_hash(input, nonce)} end)
    |> Stream.filter(fn {_nonce, hash} -> valid_hash?(hash, target_difficulty) end)
    |> Enum.at(0) # Take the first valid result
  end

  defp calculate_hash(input, nonce) do
    :crypto.hash(:sha256, input <> Integer.to_string(nonce))
    |> Base.encode16()
  end

  defp valid_hash?(hash, target_difficulty) do
    String.starts_with?(hash, String.duplicate("0", target_difficulty))
  end
end
