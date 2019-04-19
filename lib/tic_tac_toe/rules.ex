defmodule TicTacToe.Rules do
    alias TicTacToe.Board, as: Board
    
    @players ["X", "O"]
    
    def status(board) do
        board_marks = board
        |> Board.current_marks()
        
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
    
    defp rows(board_marks) do
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
        rows(board_marks)
        |> Enum.with_index()
        |> Enum.map(fn {row, index} -> Enum.at(row, index) end)
        |> Enum.all?(fn _item -> Kernel.match?(_item, @players) && _item != :empty end)
    end

    defp has_winning_right_diagonal?(board_marks) do
        rows(board_marks)
        |> Enum.reverse()
        |> Enum.with_index()
        |> Enum.map(fn {row, index} -> Enum.at(row, index) end)
        |> Enum.all?(fn _item -> Kernel.match?(_item, @players) && _item != :empty end)
    end

    defp all_elements_in_list_equal?(lists) do
        Enum.any?(lists, fn list -> 
            if !Enum.member?(list, :empty) do
                Enum.filter(list, &match?([x,x,x] when x in @players, &1))
            else
                false
            end
        end)
    end
end