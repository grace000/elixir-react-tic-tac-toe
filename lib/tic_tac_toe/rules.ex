defmodule TicTacToe.Rules do
    alias TicTacToe.Board, as: Board
    
    @players ["X", "O"]
    
    def status(board), do: board_state(Board.current_marks(board))

    def winner?(current_marks) do
        has_winning_row?(current_marks) || has_winning_column?(current_marks) || has_winning_diagonal?(current_marks)
    end

    def winning_token?(board_marks) do
        Enum.filter(board_marks, &match?([x,x,x] when x in @players, &1))
    end

    def board_dimension(board) do
        board
        |> Enum.count
        |> :math.sqrt
        |> Kernel.round
    end
    
    defp rows(board) do
        Enum.chunk_every(board, board_dimension(board))
    end

    defp columns(board) do
        rows(board)
        |> List.zip()
        |>Enum.map(&Tuple.to_list/1)
    end

    defp has_winning_row?(board) do
        rows(board)
        |> all_elements_in_list_equal?
    end

    defp has_winning_column?(board) do
        columns(board)
        |> all_elements_in_list_equal?
    end

    defp has_winning_diagonal?(board) do
        has_winning_left_diagonal?(board) || has_winning_right_diagonal?(board)
    end

    defp has_winning_left_diagonal?(board) do
        rows(board)
        |> Enum.with_index()
        |> Enum.map(fn {row, index} -> Enum.at(row, index) end)
        |> Enum.all?(fn _item -> Kernel.match?(_item, @players) end)
    end

    defp has_winning_right_diagonal?(board) do
        rows(board)
        |> Enum.reverse()
        |> Enum.with_index()
        |> Enum.map(fn {row, index} -> Enum.at(row, index) end)
        |> Enum.all?(fn _item -> Kernel.match?(_item, @players) end)
    end

    defp match_against_winning_combos(list) do
        Enum.filter(list, &match?([x,x,x] when x in @players, &1))
    end

    defp all_elements_in_list_equal?(lists) do
        Enum.any?(lists, fn list -> match_against_winning_combos(list) end)
    end

    defp board_state(board_marks) do
        cond do
            winner?(board_marks) -> winning_token?(board_marks)
            Enum.member?(board_marks, :empty) -> "in progress" 
        end
    end
end