defmodule HardComputerTest do
    use ExUnit.Case
    alias TicTacToe.HardComputer, as: Hard_comp
    alias TicTacToe.Board, as: Board

    describe "minimax" do
        test " return 0 for draw game for maximizing player" do
            
            board = %{
                    0 => "X", 1 => "O", 2 => "X",  
                    3 => "O", 4 => "X", 5 => "X",
                    6 => "O", 7 => "X", 8 => "O"
            }
        

            assert Hard_comp.minimax(board, true) == 0
        end

        test " return 0 for draw game for minimizing player" do
            
            board = %{
                    0 => "X", 1 => "O", 2 => "X",  
                    3 => "O", 4 => "X", 5 => "X",
                    6 => "O", 7 => "X", 8 => "O"
            }
        

            assert Hard_comp.minimax(board, false) == 0
        end

        test " return 1 if maximizing player won" do
            
            board = %{
                    0 => "X", 1 => "X", 2 => "O",  
                    3 => "O", 4 => "O", 5 => "O",
                    6 => "X", 7 => "X", 8 => "O"
            }

            assert Hard_comp.minimax(board, true) == 1
        end

        test " return -1 if minimizing player won" do
            
            board = %{
                    0 => "X", 1 => "X", 2 => "O",  
                    3 => "O", 4 => "O", 5 => "O",
                    6 => "X", 7 => "X", 8 => "O"
            }

            assert Hard_comp.minimax(board, false) == -1
        end

        test " return -1 if minimizing player won and board not full" do
            
            board = %{
                    0 => "X", 1 => "X", 2 => "X",  
                    3 => "O", 4 => "O"
            }

            assert Hard_comp.minimax(board, false) == -1
        end
    end

    describe "select_coordinate" do
        test " return 2" do
            
            board = %{
                0 => "X", 1 => "X", 
                3 => "O", 4 => "O", 5 => "O",
                6 => "X", 7 => "X", 8 => "O"
            }

            assert Hard_comp.select_coordinate(board) == 2
        end

        test " return 0" do
            
            board = %{
                          1 => "X", 2 => "X",  
                3 => "O", 4 => "X", 5 => "O",
                6 => "X", 7 => "O", 8 => "O"
            }

            assert Hard_comp.select_coordinate(board) == 0
        end
    end
end