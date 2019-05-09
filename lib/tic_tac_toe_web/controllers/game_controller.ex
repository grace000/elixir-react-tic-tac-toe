defmodule TicTacToeWeb.GameController do
    use TicTacToeWeb, :controller
    
    alias TicTacToe.Game, as: Game
    alias TicTacToe.Board, as: Board

    def new_game(connection, params) do
        game = select_game(params["game_type"])
        game_in_map_form = Map.from_struct(game)

        send_board_response(game_in_map_form, connection, params)
    end

    def select_game("human_vs_human") do 
        Game.setup_new_game(:human_vs_human)
    end

    def select_game("easy_computer") do 
        Game.setup_new_game(:easy_computer)
    end
    
    def send_board_response(game, connection, _params) do
        body = Jason.encode!(game)
        
        connection  
        |> put_status(200)
        |> text(body)
    end

    def fetch_board_update_request(connection) do
        connection.body_params
        |> Map.fetch("data")
    end

    def json_to_map({:ok, data}) do
        %{
            board: data["board"],
            current_player: data["currentPlayer"],
            game_status: data["gameStatus"],
            incoming_move: data["incomingMove"],
            game_type: data["gameType"],
            winning_coordinates: data["winningCoordinates"]
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

    def mapped_request(connection, _params) do
        fetch_board_update_request(connection)
        |> json_to_map
    end

    def create_move(connection, params) do
        mapped_data = mapped_request(connection, params)

        case mapped_data.game_type do
            "human_vs_human" ->
                create_human_move(connection, params)
            "easy_computer" ->
                create_computer_move(connection, params)
        end
    end

    defp create_human_move(connection, params) do
        mapped_data = mapped_request(connection, params)

        case validate_move(mapped_data.board, mapped_data.incoming_move) do
            {:ok, "Move is valid"} ->
                Game.make_move(mapped_data)
                |> Game.game_status
                |> send_board_response(connection, params)
            {:error, "Move is invalid"} -> 
                handle_error(connection)
        end
    end

    defp create_computer_move(connection, params) do
        mapped_data = mapped_request(connection, params)

        case validate_move(mapped_data.board, mapped_data.incoming_move) do
            {:ok, "Move is valid"} ->
                Game.make_move(mapped_data)
                |> Game.game_status
                |> Game.make_move(:easy_computer)
                |> Game.game_status
                |> send_board_response(connection, params)
            {:error, "Move is invalid"} -> 
                handle_error(connection)
        end
    end
end