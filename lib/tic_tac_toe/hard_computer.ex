defmodule TicTacToe.HardComputer do

    alias TicTacToe.Board, as: Board
    alias TicTacToe.Rules, as: Rules

    def select_coordinate(board) do
        scored_spaces = index_empty_spaces(board)
        |> Enum.map(fn {_space, index} ->
            {index, minimax(board, true)}
        end)
        {index, _score} = Enum.max_by(scored_spaces, fn {_index, score} -> score end)
        index
    end

    def minimax(board, is_maximizing_player) do
        case Rules.status(board) do
            :winner -> value(is_maximizing_player)
            :draw -> 0
            :in_progress -> score(board, is_maximizing_player)
        end
    end

    def score(board, is_maximizing_player) do
        if is_maximizing_player do

            empty_spaces = index_empty_spaces(board)

            scored_spaces = Enum.map(empty_spaces, fn {_space, index} ->
                new_board = Board.update(board, index, "O")
                minimax(new_board, false)

            end)
            Enum.max(scored_spaces)
        else
            empty_spaces = index_empty_spaces(board)

            scored_spaces = Enum.map(empty_spaces, fn {_space, index} ->
                new_board = Board.update(board, index, "X")
                minimax(new_board, true)
            end)
            Enum.min(scored_spaces)
        end
    end

    def index_empty_spaces(board) do
        Board.current_marks(board)
        |> Enum.with_index
        |> Enum.filter(fn {space, _index} -> space == :empty end)
    end

    def value(is_maximizing_player) when is_maximizing_player == true, do: 1
    def value(is_maximizing_player) when is_maximizing_player == false, do: -1
end
