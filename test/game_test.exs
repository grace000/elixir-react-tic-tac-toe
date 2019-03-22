defmodule GameTest do
    use ExUnit.Case
    alias TicTacToe.Game, as: Game
    alias TicTacToe.Board, as: Board

    test "it returns starting game struct" do
        assert Game.setup_new_game == %Game{game_status: :in_progress, 
                                            player_one: "x",
                                            player_two: "o",
                                            current_player: :player_one, 
                                            board: Board.empty_board}
    end
    
    describe "updating board in game struct: " do
        test "make move updates game struct for first time" do
            game = Game.setup_new_game
            
            assert Game.make_move(game, 1) == %Game{game_status: :in_progress, 
                                                player_one: "x",
                                                player_two: "o",
                                                current_player: :player_one, 
                                                board: %{player_one: 1}}
        end

        test "make move updates game struct after first time" do
            game = Game.setup_new_game
            updated_game = Game.make_move(game, 1)
            second_game_updated = Game.make_move(updated_game, 3, :player_two)
            assert  second_game_updated == %Game{game_status: :in_progress, 
                                                player_one: "x",
                                                player_two: "o",
                                                current_player: :player_one, 
                                                board: %{player_one: 1, player_two: 3}}
        end
    end
end