# head first elixir

To start your Phoenix server:

  * Run `mix setup` to install and setup dependencies
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Demo3.PoWServer

The `Demo3.PoWServer` module in the `poc.ex` file is responsible for handling Proof of Work (PoW) computations. 
requesting `http://localhost:4000/pow?input=example2` will return the result of the PoW computation.

## Demo3.TcpServer

The `Demo3.TcpServer` module in the `tcp.ex` file is responsible for handling TCP connections and decode data in pb.
```syntax = "proto3";
package search;
option go_package = "./search";
message SearchRequest {
  string query = 1;
  int32 page_number = 2;
  int32 results_per_page = 3;
}
```
run `mix protox.generate --output-path=lib/demo3/pbi.ex /Users/boya/workplace/willam/demo3/defs/pbi.proto --namespace Demo3.Pbi` to generate the pb file.



### Key Functions

  * `start_link/1` - Starts the PoW server.
  * `perform_task/2` - Performs a PoW task with given parameters.
  * `verify_task/2` - Verifies the result of a PoW task.

### Usage

To use the `Demo3.PoWServer`, you need to start it as part of

## Learn more

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix
