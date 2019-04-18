defmodule TicTacToeWeb.GameController do
    use TicTacToeWeb, :controller
    
    alias TicTacToe.Game, as: Game
    alias TicTacToe.Board, as: Board

    def new_game(connection, _params) do
        game = Game.setup_new_game
        game_in_map_form = Map.from_struct(game)
       
        send_board_response(game_in_map_form, connection, _params)
    end
    
    def send_board_response(game, connection, _params) do
        body = Jason.encode!(game)
        
        connection  
        |> put_status(200)
        |> text(body)
    end

    def fetch_board_update_request(connection) do
        response = connection.body_params
        Map.fetch(response, "data")
    end

    def json_to_map({:ok, data}) do
        %{
            board: data["board"],
            current_player: data["currentPlayer"],
            game_status: data["gameStatus"],
            incoming_move: data["incomingMove"]
        }
    end

    def validate_move(current_board, incoming_move) do
        parsed_move = to_string(incoming_move)

        case (Board.valid_move?(current_board, parsed_move)) do
            true -> 
                {:ok, "Move is valid"}
            false -> 
                {:error, "Move is invalid"}
        end
    end

    def handle_error(connection) do
        connection
        |> put_status(400)
        |> text("Oh no, that spot is already taken!")
    end

    def create_move(connection, _params) do
        data = fetch_board_update_request(connection)
        mapped_data = json_to_map(data)
        
        case validate_move(mapped_data.board, mapped_data.incoming_move) do
            {:ok, "Move is valid"} ->
                Game.make_move(mapped_data)
                |> Game.game_status
                |> send_board_response(connection, _params)
            {:error, "Move is invalid"} -> 
                handle_error(connection)
        end
    end

end