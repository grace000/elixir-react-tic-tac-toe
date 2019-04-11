defmodule TicTacToeWeb.GameController do
    use TicTacToeWeb, :controller
    
    alias TicTacToe.Game, as: Game

    def new_game(connection, _params) do
        game = Game.setup_new_game
        game_in_map_form = Map.from_struct(game)
        body = Jason.encode!(game_in_map_form)

        connection
        |> put_status(200)
        |> text(body)
    end
    
    def send_board_update_response(updated_game, connection, _params) do
        body = Jason.encode!(updated_game)

        connection  
        |> put_status(200)
        |> text(body)
    end

    def fetch_board_update_request(connection) do
        response = connection.body_params
        Map.fetch(response, "data")
    end

    def json_to_map(contents) do
        case (contents) do
            {:ok, data} -> %{
                board: data["board"],
                current_player: data["currentPlayer"],
                game_status: data["gameStatus"],
                incoming_move: data["incomingMove"]
            }
        end
    end

    def create_move(connection, _params) do
        fetch_board_update_request(connection)
        |> json_to_map
        |> Game.make_move
        |> send_board_update_response(connection, _params)
    end

end