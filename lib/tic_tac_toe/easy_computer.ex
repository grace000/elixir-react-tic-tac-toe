defmodule TicTacToe.EasyComputer do

    def select_coordinate(board_marks) do
        coordinate = generate_random_num(board_marks)

        cond do
            Enum.at(board_marks, coordinate) != :empty ->
                select_coordinate(board_marks)
            true -> coordinate
        end
    end

    def generate_random_num(board_marks) do
        marks = Enum.count(board_marks)

        Enum.random(0..marks)
    end
end