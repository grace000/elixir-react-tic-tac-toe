defmodule TicTacToe.Rules do
    alias TicTacToe.Board, as: Board
    
    def status(board) do
        board_marks = Board.current_marks(board)

        cond do
            winner?(board_marks) -> :winner
            Enum.member?(board_marks, :empty) -> :in_progress
            true -> :draw
        end
    end

    defp winner?(board_marks) do
        has_winning_row?(board_marks) || has_winning_column?(board_marks) || has_winning_diagonal?(board_marks)
    end

    defp board_dimension(board_marks) do
        board_marks
        |> Enum.count
        |> :math.sqrt
        |> Kernel.round
    end
    
    def rows(board_marks) do
        Enum.chunk_every(board_marks, board_dimension(board_marks))
    end

    defp columns(board_marks) do
        rows(board_marks)
        |> List.zip()
        |>Enum.map(&Tuple.to_list/1)
    end

    defp has_winning_row?(board_marks) do
        rows(board_marks)
        |> all_elements_in_list_equal?
    end

    defp has_winning_column?(board_marks) do
        columns(board_marks)
        |> all_elements_in_list_equal?
    end

    defp has_winning_diagonal?(board_marks) do
        has_winning_left_diagonal?(board_marks) || has_winning_right_diagonal?(board_marks)
    end

    defp has_winning_left_diagonal?(board_marks) do
        diag_marks = board_marks
        |> Enum.take_every(2)
        |> Enum.take_every(2)

        diag_marks == ["X", "X", "X"] || diag_marks == ["O", "O", "O"]
       
    end

    defp has_winning_right_diagonal?(board_marks) do
        diag_marks = board_marks
        |> Enum.slice(2..6)
        |> Enum.take_every(2)

        diag_marks == ["X", "X", "X"] || diag_marks == ["O", "O", "O"]

    end


    def all_elements_in_list_equal?(lists) do
        Enum.map(lists, fn list -> list end)
        |> Enum.any?(fn x -> x == ["X", "X", "X"] || x == ["O", "O", "O"] end)
    end

end