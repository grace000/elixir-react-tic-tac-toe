defmodule EasyComputerTest do
    use ExUnit.Case
    alias TicTacToe.EasyComputer, as: Ez_comp

    describe "select_coordinate" do
        test " does not return coordinate 1" do
            board_marks = [
                :empty,
                "X",
                :empty,
                :empty,
                :empty,
                :empty,
                :empty,
                :empty,
                :empty
               ]
        
        assert Ez_comp.select_coordinate(board_marks) != 1
        end

        test " does not return coordinates 1,3, or 5" do
            board_marks = [
                :empty,
                "X",
                :empty,
                "O",
                :empty,
                "X",
                :empty,
                :empty,
                :empty
               ]

        assert Ez_comp.select_coordinate(board_marks) != 1
        assert Ez_comp.select_coordinate(board_marks) != 3
        assert Ez_comp.select_coordinate(board_marks) != 5
        end

        test " returns 0 coordinate" do
            board_marks = [
                :empty,
                "X",
                "O",
                "O",
                "X",
                "X",
                "O",
                "X",
                "O"
               ]
        
        assert Ez_comp.select_coordinate(board_marks) == 0
        end
    end
end