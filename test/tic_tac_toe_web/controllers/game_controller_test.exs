defmodule TicTacToeWeb.GameControllerTest do
    use TicTacToeWeb.ConnCase

    alias TicTacToeWeb.GameController, as: Controller
    
    describe "new_game" do
        test " it returns empty game struct and ok response", %{conn: conn} do
            conn = get(build_conn(), "/new_game")
            
            assert conn.resp_body =~ "{\"board\":{},\"current_player\":\"X\",\"game_status\":\"in progress\",\"incoming_move\":null}"
        end
    end
    
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

    describe "json_to_map" do
        test " converts incoming json with no board moves to map" do
            data = {
                :ok,
                %{
                  "board" => %{},
                  "currentPlayer" => "O",
                  "gameStatus" => "in progress",
                  "incomingMove" => 2
                }
            }

            assert Controller.json_to_map(data) == %{
                                                    board: %{},
                                                    current_player: "O",
                                                    game_status: "in progress",
                                                    incoming_move: 2
                                                   }
        end

        test " converts incoming json with two board moves map" do
            data = {
                :ok,
                %{
                  "board" => %{1 => "X", 5 => "O"},
                  "currentPlayer" => "X",
                  "gameStatus" => "in progress",
                  "incomingMove" => 2
                }
            }

            assert Controller.json_to_map(data) == %{
                                                    board: %{1 => "X", 5 => "O"},
                                                    current_player: "X",
                                                    game_status: "in progress",
                                                    incoming_move: 2
                                                   }
        end
    end
end