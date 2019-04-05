defmodule GameTest do
    use ExUnit.Case
    alias TicTacToe.Game, as: Game
    alias TicTacToe.Board, as: Board

    test "it returns starting game struct" do
        assert Game.setup_new_game == %Game{game_status: "in progress", 
                                            current_player: "X", 
                                            incoming_move: nil,
                                            board: Board.empty_board}
    end
    
    describe "updating board in game struct: " do
        test "make move updates game struct for first time" do
            game = %{game_status: "in progress", 
                     current_player: "X", 
                     incoming_move: 1,
                     board: %{}}
            
            assert Game.make_move(game) == %{game_status: "in progress", 
                                                current_player: "X", 
                                                incoming_move: 1,
                                                board: %{1 => "X"}}
        end

        test "make move updates game struct after first time" do
            game = %{game_status: "in progress", 
                    current_player: "X", 
                    incoming_move: 1,
                    board: %{}}
            
            updated_game = Game.make_move(game)
            
            second_game_updated = %{game_status: "in progress", 
                                    current_player: "O", 
                                    incoming_move: 3,
                                    board: %{1 => "X"}}
            
            assert  Game.make_move(second_game_updated) == %{game_status: "in progress", 
                                                current_player: "O",
                                                incoming_move: 3, 
                                                board: %{1 => "X", 3 => "O"}}
        end
    end
end