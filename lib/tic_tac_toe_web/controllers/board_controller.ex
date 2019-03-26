defmodule TicTacToeWeb.BoardController do
    use TicTacToeWeb, :controller
  
    alias TicTacToe.Board, as: Board
    alias TicTacToe.Game, as: Game
  
    def board_status(conn, _params) do
        
        body = Jason.encode!(%{0 => "X", 1 => "O", 2 => "X"})

        conn
        |> put_status(200)
        |> text(body)
    end
end