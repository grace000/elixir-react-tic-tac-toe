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
    
            _board_2 = Board.update(board_1, 1, :player_two)
            assert board_2 = %{0 => :player_one, 1 => :player_two}
        end
    
        test "single player can make multiple moves" do
            board_1 = Board.update(Board.empty_board, 0, :player_one)
            assert board_1 == %{0 => :player_one}
    
            _board_2 = Board.update(board_1, 1, :player_one)
            assert board_2 = %{0 => :player_one, 1 => :player_one}
        end
    
        test "two players can make multiple moves" do
            board_1 = Board.update(Board.empty_board, 0, :player_one)
            assert board_1 == %{0 => :player_one}
    
            _board_2 = Board.update(board_1, 1, :player_two)
            assert board_2 = %{0 => :player_one, 1 => :player_two}
    
            _board_3 = Board.update(board_2, 3, :player_one)
            assert board_3 = %{0 => :player_one, 1 => :player_two, 3 => :player_one}
    
            _board_4 = Board.update(board_3, 5, :player_two)
            assert board_4 = %{0 => :player_one, 1 => :player_two, 3 => :player_one, 5 => :player_two}
        end
    end

    describe "get_board_moves" do
        test "returns list of moves" do
            board_1 = Board.update(Board.empty_board, 0, :player_one)
            _board_2 = Board.update(board_1, 1, :player_two)
        
            assert board_2 = %{0 => :player_one, 1 => :player_two}
            assert Board.get_board_moves(board_2) == [0,1]
        end
    end

    describe "current_marks" do
        test "returns list with single mark on the board and placeholder for 8 remaining spaces" do
            board = Board.update(Board.empty_board, 1, :player_one)

            assert Board.current_marks(board) == [
                                                  :empty,
                                                  :player_one,
                                                  :empty,
                                                  :empty,
                                                  :empty,
                                                  :empty,
                                                  :empty,
                                                  :empty,
                                                  :empty
                                                 ]
        end

        test "returns list with two marks on the board and placeholder for 7 remaining spaces" do
            board_1 = Board.update(Board.empty_board, 1, :player_one)
            board_2 = Board.update(board_1, 8, :player_two)

            assert Board.current_marks(board_2) == [
                                                    :empty,
                                                    :player_one,
                                                    :empty,
                                                    :empty,
                                                    :empty,
                                                    :empty,
                                                    :empty,
                                                    :empty,
                                                    :player_two
                                                   ]
        end

        test "returns list with three marks on the board and placeholder for 6 remaining spaces" do
            board_1 = Board.update(Board.empty_board, 1, :player_one)
            board_2 = Board.update(board_1, 8, :player_two)
            board_3 = Board.update(board_2, 4, :player_one)

            assert Board.current_marks(board_3) == [
                                                    :empty,
                                                    :player_one,
                                                    :empty,
                                                    :empty,
                                                    :player_one,
                                                    :empty,
                                                    :empty,
                                                    :empty,
                                                    :player_two
                                                   ]
        end
    end

    describe "valid_move?" do
        test "returns true if move is not already on the board" do
            board_1 = %{0 => "X", 3 => "O", 6 => "X"}
            board_2 = %{3 => "X", 4 => "O", 5 => "X"}
            board_3 = %{6 => "X", 7 => "O"}

            assert Board.valid_move?(board_1, 1) == true
            assert Board.valid_move?(board_2, 2) == true
            assert Board.valid_move?(board_3, 4) == true
        end

        test "returns false if move is already on the board" do
            board_1 = %{0 => "X", 3 => "O", 6 => "X"}
            board_2 = %{3 => "X", 4 => "O", 5 => "X"}
            board_3 = %{6 => "X", 7 => "O"}

            assert Board.valid_move?(board_1, 0) == false
            assert Board.valid_move?(board_2, 3) == false
            assert Board.valid_move?(board_3, 7) == false
        end
    end

    describe "full?" do
        test "returns true when board does not have any empty marks" do
            board = Board.empty_board
            |> Board.update(0, "X")
            |> Board.update(1, "O")
            |> Board.update(2, "X")
            |> Board.update(3, "X")
            |> Board.update(4, "X")
            |> Board.update(5, "O")
            |> Board.update(6, "O")
            |> Board.update(7, "X")
            |> Board.update(8, "O")

            assert Board.full?(board) == true
        end
    end
  end