defmodule TicTacToeWeb.BoardController do
    use TicTacToeWeb, :controller
    
    # alias TicTacToe.Board, as: Board
    alias TicTacToe.Game, as: Game

    def new_game(conn, _params) do
        game = Game.setup_new_game
        game_in_map_form = Map.from_struct(game)
        body = Jason.encode!(game_in_map_form)

        conn
        |> put_status(200)
        |> text(body)
    end
    
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