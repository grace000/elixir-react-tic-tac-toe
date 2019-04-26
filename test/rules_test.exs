defmodule RulesTest do
    use ExUnit.Case
    alias TicTacToe.Rules, as: Rules
    alias TicTacToe.Board, as: Board
    
    describe "status" do
    
    
        test " it returns in progress if there are no marks on the board" do
            board = Board.empty_board

            assert Rules.status(board) == :in_progress
        end

        test " it returns in progress if there two marks on the board" do
           board = Board.empty_board
           |> Board.update(1, "X")
           |> Board.update(3, "O")

           assert Rules.status(board) == :in_progress
        end

        test " it returns in progress if there are 7 marks on the board" do
            board = Board.empty_board
            |> Board.update(0, "X")
            |> Board.update(1, "O")
            |> Board.update(2, "X")
            |> Board.update(3, "X")
            |> Board.update(4, "X")
            |> Board.update(5, "O")
            |> Board.update(6, "O")

            assert Rules.status(board) == :in_progress
        end

        test " it returns a draw if board is full but there is no winner" do
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

            assert Rules.status(board) == :draw
        end
    
        test " it returns winner when winner is on the first row of the board" do
            board = Board.empty_board
            |> Board.update(1, "X")
            |> Board.update(0, "X")
            |> Board.update(2, "X")

           assert Rules.status(board) == :winner
        end

       test " it returns winner when winner is on the second row of the board" do
            board = Board.empty_board
            |> Board.update(3, "X")
            |> Board.update(4, "X")
            |> Board.update(5, "X")

            assert Rules.status(board) == :winner
        end

        test " it returns winner when winner is on the third row of the board" do
            board = Board.empty_board
            |> Board.update(6, "X")
            |> Board.update(3, "O")
            |> Board.update(7, "X")
            |> Board.update(4, "O")
            |> Board.update(8, "X")

            assert Rules.status(board) == :winner
        end

        test " it returns winner when winner is on the left to right cross on the board" do
            board = Board.empty_board
            |> Board.update(0, "X")
            |> Board.update(3, "O")
            |> Board.update(4, "X")
            |> Board.update(6, "O")
            |> Board.update(8, "X")

            assert Rules.status(board) == :winner
        end

        test " it returns winner when winner is on the right to left cross on the board" do
            board = Board.empty_board
            |> Board.update(2, "X")
            |> Board.update(3, "O")
            |> Board.update(4, "X")
            |> Board.update(8, "O")
            |> Board.update(6, "X")

            assert Rules.status(board) == :winner
        end

        test " it returns winner and coordinates when winner is on the first column" do
            board = Board.empty_board
            |> Board.update(1, "X")
            |> Board.update(3, "O")
            |> Board.update(4, "X")
            |> Board.update(6, "O")
            |> Board.update(2, "X")
            |> Board.update(0, "O")

            assert Rules.status(board) == :winner
        end

        test " it returns winner when winner is on the second column" do
            board = Board.empty_board
            |> Board.update(0, "X")
            |> Board.update(1, "O")
            |> Board.update(2, "X")
            |> Board.update(4, "O")
            |> Board.update(8, "X")
            |> Board.update(7, "O")

            assert Rules.status(board) == :winner
        end

        test " it returns winner and coordinates when winner is on the third column" do
            board = Board.empty_board
            |> Board.update(2, "X")
            |> Board.update(1, "O")
            |> Board.update(5, "X")
            |> Board.update(4, "O")
            |> Board.update(8, "X")

            assert Rules.status(board) == :winner
        end
    end

    describe "all_elements_in_list_equal?" do
        test " it returns false when there are not three equal elements in the list" do
            board_marks = [
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
        
        lists = Rules.rows(board_marks)

        assert Rules.all_elements_in_list_equal?(lists) == false
        end
    end
end