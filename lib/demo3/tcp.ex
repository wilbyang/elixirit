defmodule Demo3.TcpServer do

  @moduledoc """
  Documentation for `TcpServer`.
  """
  alias Demo3.Pbi.SearchRequest
  require Logger
  def start(port) do
    # Start listening on the specified port
    {:ok, socket} = :gen_tcp.listen(port, [:binary, active: false, reuseaddr: true])
    Logger.info("Server listening on port #{port}")

    # Accept incoming connections
    accept_loop(socket)
  end

  defp accept_loop(socket) do
    # Wait for a client to connect
    {:ok, client_socket} = :gen_tcp.accept(socket)
    Logger.info("Client connected")

    # Handle the client in a separate process
    spawn(fn -> handle_client(client_socket) end)

    # Continue accepting new clients
    accept_loop(socket)
  end

  defp handle_client(socket) do
    # Receive data from the client
    case :gen_tcp.recv(socket, 0) do

      {:ok, data} ->

        case SearchRequest.decode(data) do
          {:ok, %SearchRequest{query: query, results_per_page: results_per_page, page_number: page_number}} ->
            Logger.info("Received data: #{query} #{results_per_page} #{page_number}")
          {:error, _} ->
            IO.puts("Error decoding data: ")
        end

        # Send a response back to the client
        :gen_tcp.send(socket, "Hello from Elixir TCP server!\n")

        # Handle more data from the client
        handle_client(socket)

      {:error, :closed} ->
        IO.puts("Client disconnected")
    end
  end
  def start_link do
    port = 4040  # Specify the port number
    Task.start_link(fn -> start(port) end)
  end
end
