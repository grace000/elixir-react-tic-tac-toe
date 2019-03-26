defmodule TicTacToeWeb.PageController do
  use TicTacToeWeb, :controller

  alias TicTacToe.Board, as: Board

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
