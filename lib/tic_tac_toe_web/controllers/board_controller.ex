defmodule TicTacToeWeb.BoardController do
    use TicTacToeWeb, :controller
  
    alias TicTacToe.Board, as: Board
    alias TicTacToe.Game, as: Game
  
    def board_status(conn, _params) do
        body = Jason.encode!(%{0 => "X", 1 => "O", 2 => "X", 3 => "O", 4 => "X"})

        conn
        |> put_status(200)
        |> text(body)
    end

    def post_move(conn, _params) do
        update_board_status(conn)
        
        conn   
        |> put_status(:ok)
        |> send_resp(200, "ok")
    end

    def update_board_status(conn) do
       IO.inspect conn.body_params
    end
end