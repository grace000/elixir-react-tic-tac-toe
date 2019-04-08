defmodule TicTacToeWeb.GameControllerTest do
    use TicTacToeWeb.ConnCase

    alias TicTacToeWeb.GameController, as: Controller
    
    describe "send_board_update_response" do
        test " it receives connection and returns ok response", %{conn: conn} do
            conn = build_conn(:post, "/api/createmove", %{"moves" => [nil, nil, nil, nil, nil, nil, nil, nil, nil]})
            
            assert conn.params ==  %{"moves" => [nil, nil, nil, nil, nil, nil, nil, nil, nil]}
        end
    end

    describe "fetch_board_update_request" do
        test " returns moves data from post method", %{conn: conn} do
            data = %{
                "data" => %{"moves" => [nil, nil, nil, "X", nil, nil, nil, nil, nil]},
                "headers" => %{"Content-Type" => "application/json"}
            }
            
            conn = build_conn(:post, "/api/createmove", data)
            
            assert  Controller.fetch_board_update_request(conn) == {:ok, %{"moves" => [nil, nil, nil, "X", nil, nil, nil, nil, nil]}}
        end
    end

    describe "list_to_map" do
        test " returns empty map" do
            board = []

            assert Controller.list_to_map(board) == %{}
        end

        test " returns map with one item" do
            board = ["X"]

            assert Controller.list_to_map(board) == %{0 => "X"}
        end

        test " returns map with two items" do
            board = ["X", "O"]

            assert Controller.list_to_map(board) == %{0 => "X", 1 => "O"}
        end
    end

    describe "json_to_map" do
        test " conversts incoming json to map" do
            data = {:ok,
            %{
              "board" => [],
              "currentPlayer" => "O",
              "gameStatus" => "in progress",
              "incomingMove" => 2
            }}

            assert Controller.json_to_map(data) == %{board: %{},
                                                    current_player: "O",
                                                    game_status: "in progress",
                                                    incoming_move: 2}
        end
    end
end