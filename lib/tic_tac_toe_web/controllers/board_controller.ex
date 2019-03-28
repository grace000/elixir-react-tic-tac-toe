defmodule TicTacToeWeb.BoardController do
    use TicTacToeWeb, :controller
  
    def post_move(connection, _params) do
        connection  
        |> put_status(:ok)
        |> send_resp(200, "ok")
    end

    def fetch_board_update_request(connection) do
        response = connection.body_params
        Map.fetch(response, "data")
    end

    def create_move(connection, _params) do
        fetch_board_update_request(connection)
        post_move(connection, _params)
    end
end