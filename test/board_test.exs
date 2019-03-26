defmodule BoardTest do
    use ExUnit.Case
    alias TicTacToe.Board, as: Board
  
    describe "marking marks on the board" do
        test "it returns an empty board" do
            assert Board.empty_board == %{}
        end
    
        test "one player can make one mark on the board" do
            board = Board.update(Board.empty_board, 0, :player_one)
    
            assert board == %{0 => :player_one}
        end
    
        test "two players can each mark the board" do
            board_1 = Board.update(Board.empty_board, 0, :player_one)
            assert board_1 == %{0 => :player_one}
    
            board_2 = Board.update(board_1, 1, :player_two)
            assert board_2 = %{0 => :player_one, 1 => :player_two}
        end
    
        test "single player can make multiple moves" do
            board_1 = Board.update(Board.empty_board, 0, :player_one)
            assert board_1 == %{0 => :player_one}
    
            board_2 = Board.update(board_1, 1, :player_one)
            assert board_2 = %{0 => :player_one, 1 => :player_one}
        end
    
        test "two players can make multiple moves" do
            board_1 = Board.update(Board.empty_board, 0, :player_one)
            assert board_1 == %{0 => :player_one}
    
            board_2 = Board.update(board_1, 1, :player_two)
            assert board_2 = %{0 => :player_one, 1 => :player_two}
    
            board_3 = Board.update(board_2, 3, :player_one)
            assert board_3 = %{0 => :player_one, 1 => :player_two, 3 => :player_one}
    
            board_4 = Board.update(board_3, 5, :player_two)
            assert board_4 = %{0 => :player_one, 1 => :player_two, 3 => :player_one, 5 => :player_two}
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

    describe "current_marks" do
        test "returns list with single mark on the board and placeholder for 8 remaining spaces" do
            board = Board.update(Board.empty_board, 1, :player_one)

            assert Board.current_marks(board) == [:empty,
                                                    :player_one,
                                                    :empty,
                                                    :empty,
                                                    :empty,
                                                    :empty,
                                                    :empty,
                                                    :empty,
                                                    :empty]
        end

        test "returns list with single mark on the board and placeholder for 7 remaining spaces" do
            board_1 = Board.update(Board.empty_board, 1, :player_one)
            board_2 = Board.update(board_1, 8, :player_two)

            assert Board.current_marks(board_2) == [:empty,
                                                    :player_one,
                                                    :empty,
                                                    :empty,
                                                    :empty,
                                                    :empty,
                                                    :empty,
                                                    :empty,
                                                    :player_two]
        end
    end
  end