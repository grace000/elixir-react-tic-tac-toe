defmodule BoardTest do
    use ExUnit.Case
    alias TicTacToe.Board, as: Board
  
    describe "marking marks on the board" do
        test "it returns an empty board" do
            assert Board.empty_board == %{}
        end
    
        test "one player can make one mark on the board" do
            board = Board.update(Board.empty_board, 0, :player_one)
    
            assert board == %{player_one: 0}
        end
    
        test "two players can each mark the board" do
            board_1 = Board.update(Board.empty_board, 0, :player_one)
            assert board_1 == %{player_one: 0}
    
            board_2 = Board.update(board_1, 1, :player_two)
            assert board_2 = %{player_one: 0, player_two: 1}
        end
    
        test "single player can make multiple moves" do
            board_1 = Board.update(Board.empty_board, 0, :player_one)
            assert board_1 == %{player_one: 0}
    
            board_2 = Board.update(board_1, 1, :player_one)
            assert board_2 = %{player_one: [0,1]}
        end
    
        test "two players can make multiple moves" do
            board_1 = Board.update(Board.empty_board, 0, :player_one)
            assert board_1 == %{player_one: 0}
    
            board_2 = Board.update(board_1, 1, :player_two)
            assert board_2 = %{player_one: 0, player_two: 1}
    
            board_3 = Board.update(board_2, 3, :player_one)
            assert board_3 = %{player_one: [0,3], player_two: 1}
    
            board_4 = Board.update(board_3, 5, :player_two)
            assert board_4 = %{player_one: [0,3], player_two: [1,5]}
        end
    end

    describe "get_board_moves" do
        test "returns list of moves" do
            board_1 = Board.update(Board.empty_board, 0, :player_one)
            board_2 = Board.update(board_1, 1, :player_two)
        
            assert board_2 = %{player_one: 0, player_two: 1}
            assert Board.get_board_moves(board_2) == [0,1]
        end
    end
  end