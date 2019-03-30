defmodule GameTest do
    use ExUnit.Case
    alias TicTacToe.Game, as: Game
    alias TicTacToe.Board, as: Board

    test "it returns starting game struct" do
        assert Game.setup_new_game == %Game{game_status: "in progress", 
                                            player_one: "X",
                                            player_two: "O",
                                            current_player: "X", 
                                            board: Board.empty_board}
    end
    
    describe "updating board in game struct: " do
        test "make move updates game struct for first time" do
            game = Game.setup_new_game
            
            assert Game.make_move(game, 1, "X") == %Game{game_status: "in progress", 
                                                player_one: "X",
                                                player_two: "O",
                                                current_player: "X", 
                                                board: %{1 => "X"}}
        end

        test "make move updates game struct after first time" do
            game = Game.setup_new_game
            updated_game = Game.make_move(game, 1, "X")
            second_game_updated = Game.make_move(updated_game, 3, "O")
            assert  second_game_updated == %Game{game_status: "in progress", 
                                                player_one: "X",
                                                player_two: "O",
                                                current_player: "X", 
                                                board: %{1 => "X", 3 => "O"}}
        end
    end
end