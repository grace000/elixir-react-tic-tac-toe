defmodule RulesTest do
    use ExUnit.Case
    alias TicTacToe.Rules, as: Rules
    alias TicTacToe.Board, as: Board

    describe "in_progress?" do
        test " it returns true if there are no marks on the board" do
            board = Board.empty_board

            assert Rules.in_progress?(board)
        end

    end
    
    describe "status" do
       test " it returns in progress if there are no marks on the board" do
           board = Board.empty_board

           assert Rules.status(board) == "in progress"
       end

       test " it returns in progress if there two marks on the board" do
           board = Board.empty_board
           |> Board.update(1, "X")
           |> Board.update(3, "O")

           assert Rules.status(board) == "in progress"
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

        assert Rules.status(board) == "draw"
    end
    
       test " it returns winner and coordinates when winner is on the first row of the board" do
            board = Board.empty_board
            |> Board.update(1, "X")
            |> Board.update(3, "O")
            |> Board.update(0, "X")
            |> Board.update(4, "O")
            |> Board.update(2, "X")

           assert Rules.status(board) == {"X", [0,1,2]}
       end

       test " it returns winner and coordinates when winner is on the second row of the board" do
            board = Board.empty_board
            |> Board.update(0, "X")
            |> Board.update(1, "O")
            |> Board.update(3, "X")
            |> Board.update(7, "O")
            |> Board.update(4, "X")
            |> Board.update(8, "O")
            |> Board.update(5, "X")

            assert Rules.status(board) == {"X", [3,4,5]}
        end

        test " it returns winner and coordinates when winner is on the third row of the board" do
            board = Board.empty_board
            |> Board.update(6, "X")
            |> Board.update(3, "O")
            |> Board.update(7, "X")
            |> Board.update(4, "O")
            |> Board.update(8, "X")

            assert Rules.status(board) == {"X", [6,7,8]}
        end

        test " it returns winner and coordinates when winner is on the left to right cross on the board" do
            board = Board.empty_board
            |> Board.update(0, "X")
            |> Board.update(3, "O")
            |> Board.update(4, "X")
            |> Board.update(6, "O")
            |> Board.update(8, "X")

            assert Rules.status(board) == {"X", [0,4,8]}
        end

        test " it returns winner and coordinates when winner is on the right to left cross on the board" do
            board = Board.empty_board
            |> Board.update(2, "X")
            |> Board.update(3, "O")
            |> Board.update(4, "X")
            |> Board.update(8, "O")
            |> Board.update(6, "X")

            assert Rules.status(board) == {"X", [2,4,6]}
        end

        test " it returns winner and coordinates when winner is on the first column" do
            board = Board.empty_board
            |> Board.update(1, "X")
            |> Board.update(3, "O")
            |> Board.update(4, "X")
            |> Board.update(6, "O")
            |> Board.update(2, "X")
            |> Board.update(0, "O")

            assert Rules.status(board) == {"O", [0,3,6]}
        end

        test " it returns winner and coordinates when winner is on the second column" do
            board = Board.empty_board
            |> Board.update(0, "X")
            |> Board.update(1, "O")
            |> Board.update(2, "X")
            |> Board.update(4, "O")
            |> Board.update(8, "X")
            |> Board.update(7, "O")

            assert Rules.status(board) == {"O", [1,4,7]}
        end

        test " it returns winner and coordinates when winner is on the third column" do
            board = Board.empty_board
            |> Board.update(2, "X")
            |> Board.update(1, "O")
            |> Board.update(5, "X")
            |> Board.update(4, "O")
            |> Board.update(8, "X")

            assert Rules.status(board) == {"X", [2,5,8]}
        end
    end

end