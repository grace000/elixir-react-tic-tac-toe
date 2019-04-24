defmodule GameTest do
    use ExUnit.Case
    alias TicTacToe.Game, as: Game
    alias TicTacToe.Board, as: Board
    alias TicTacToe.EasyComputer, as: EasyComputer

    describe "setup_new_game" do
        test " it returns a new human vs human struct when starting a game" do
            game_type = :human_vs_human

            assert Game.setup_new_game(game_type) == %Game {
                                                        game_type: :human_vs_human,
                                                        game_status: "", 
                                                        current_player: "X", 
                                                        incoming_move: nil,
                                                        board: Board.empty_board
                                                    }
        end
    end
    
    describe "updating board in game struct: " do
        test "make move updates game struct for first time" do
            game = %{
                    game_status: "", 
                    current_player: "X", 
                    incoming_move: 1,
                    board: %{}
                    }
            
            assert Game.make_move(game) == %{
                                            game_status: "", 
                                            current_player: "O", 
                                            incoming_move: 1,
                                            board: %{1 => "X"}
                                            }
        end

        test "make move updates game struct after first time" do
            game = %{
                    game_status: "", 
                    current_player: "X", 
                    incoming_move: 1,
                    board: %{}
                    }
            
            _updated_game = Game.make_move(game)
            
            second_game_updated = %{
                                    game_status: :in_progress, 
                                    current_player: "O", 
                                    incoming_move: 3,
                                    board: %{"1" => "X"}
                                    }
            
            assert  Game.make_move(second_game_updated) == %{
                                                            game_status: :in_progress, 
                                                            current_player: "X",
                                                            incoming_move: 3, 
                                                            board: %{1 => "X", 3 => "O"}
                                                            }
        end

        test " make_move allows easy computer to update game" do
            game = %{
                game_status: :in_progress, 
                current_player: "O", 
                incoming_move: 1,
                board: %{"1" => "X"}
            }
            
            board = Board.current_marks(game.board)
            coordinate = EasyComputer.select_coordinate(board)

            assert Game.make_move(game, :easy_computer) == %{
                                            game_status: :in_progress, 
                                            current_player: "X",
                                            incoming_move: coordinate, 
                                            board: %{1 => "X", coordinate => "O"}
                                            }
        end
    end

    describe "switch_player" do
        test " returns x when the current player is o" do
            player = "X"

            assert Game.switch_player(player) == "O"
        end

        test " returns o when the current player is x" do
            player = "O"

            assert Game.switch_player(player) == "X"
        end
    end

    describe "game_status" do
        test " returns game map with updated game status" do
            game = %{
                game_status: "", 
                current_player: "X", 
                incoming_move: 1,
                board: %{}
            }
        
            _updated_game = Game.make_move(game)
            
            second_game = %{
                            game_status: :in_progress, 
                            current_player: "X", 
                            incoming_move: 2,
                            board: %{"1" => "X"}
                            }
                                    
            _second_update = Game.make_move(second_game)
            
            third_game = %{
                game_status: :in_progress, 
                current_player: "X",
                incoming_move: 0, 
                board: %{"1" => "X", "2" => "X"}
                }
            
            third_update = Game.make_move(third_game)

            assert third_update.board == %{1 => "X", 2 => "X", 0 => "X"}
            assert Game.game_status(third_update) == %{
                                                            game_status: :winner, 
                                                            current_player: "O",
                                                            incoming_move: 0, 
                                                            board: %{1 => "X", 2 => "X", 0 => "X"}
                                                            }
        end
    end
end