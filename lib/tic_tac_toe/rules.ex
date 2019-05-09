defmodule TicTacToe.Rules do
    alias TicTacToe.Board, as: Board
    
    @players ["X", "O"]

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
        |> Enum.map(&Tuple.to_list/1)
    end

    defp positive_slope_diagonal(board_marks) do
        start = board_dimension(board_marks) - 1
        increment = start
        diagonal(board_marks, start, increment)
    end

    defp negative_slope_diagonal(board_marks) do
        start = 0
        increment = board_dimension(board_marks) + 1
        diagonal(board_marks, start, increment)
    end

    defp diagonal(board_marks, start, increment) do
        board_marks
        |> Enum.drop(start)
        |> Enum.take_every(increment)
        |> Enum.take(board_dimension(board_marks))
    end

    defp diagonals(board_marks) do
        [positive_slope_diagonal(board_marks), negative_slope_diagonal(board_marks)]
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
        winning_negative_slope_diagonal?(board_marks) || winning_positive_slope_diagonal?(board_marks)
    end

    defp winning_negative_slope_diagonal?(board_marks) do
        diag_marks = negative_slope_diagonal(board_marks)

        Enum.count(Enum.uniq(diag_marks)) == 1 && !Enum.member?(diag_marks, :empty)
    end

    defp winning_positive_slope_diagonal?(board_marks) do
        diag_marks = positive_slope_diagonal(board_marks)

        Enum.count(Enum.uniq(diag_marks)) == 1 && !Enum.member?(diag_marks, :empty)
    end

    def all_elements_in_list_equal?(lists) do
        Enum.map(lists, fn list -> list end)
          |> Enum.any?(fn x -> 
            Enum.count(Enum.uniq(x)) == 1 && !Enum.member?(x, :empty) end)
    end

    def winning_coordinates(board) do
        winning_tuples = indexed_match(board)
        |> find_match
        
        Enum.map(winning_tuples, fn {_key, val} -> val end)
    end

    def winning_token(board) do
        winning_tuples = indexed_match(board)
        |> find_match

        List.first(Enum.map(winning_tuples, fn {key, _val} -> key end))
    end

    defp indexed_match(board) do
        board_marks = Board.current_marks(board)
        
        indexed_board = board_marks
        |> Enum.with_index

        cond do
            has_winning_row?(board_marks) -> rows(indexed_board)
            has_winning_column?(board_marks) -> columns(indexed_board)
            has_winning_diagonal?(board_marks) -> diagonals(indexed_board)
        end
    end

    defp find_match(collection) do
        Enum.find(collection, fn element -> 
            match?([{x, _}, {x, _}, {x, _}] when x in @players, element)
        end)
    end
end