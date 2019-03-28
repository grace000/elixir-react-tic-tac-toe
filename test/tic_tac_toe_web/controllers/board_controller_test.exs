defmodule TicTacToeWeb.BoardControllerTest do
    use TicTacToeWeb.ConnCase

    alias TicTacToeWeb.BoardController, as: Controller

    describe "post_move" do
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
end