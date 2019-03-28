defmodule TicTacToeWeb.BoardController do
    use TicTacToeWeb, :controller
  
    def post_move(conn, _params) do
        conn  
        |> put_status(:ok)
        |> send_resp(200, "ok")
    end

    def fetch_board_update_request(conn) do
        response = conn.body_params
        data = Map.fetch(response, "data")
    end

    def create_move(conn, _params) do
        fetch_board_update_request(conn)
        post_move(conn, _params)
    end
end