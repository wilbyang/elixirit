defmodule Demo3Web.PowController do
  use Demo3Web, :controller
  alias Demo3.PoWServer
  def solve(conn, %{"input" => input}) do
    {nonce, hash} = PoWServer.solve_puzzle(input)
    json(conn, %{input: input, nonce: nonce, hash: hash})
  end

end
