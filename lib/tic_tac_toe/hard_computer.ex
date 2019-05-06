defmodule TicTacToe.HardComputer do

    alias TicTacToe.Board, as: Board
    alias TicTacToe.Rules, as: Rules

    def select_coordinate(board) do
        board_spaces = Board.current_marks(board)
            
        indexed_spaces = Enum.with_index(board_spaces)

        empty_spaces = Enum.filter(indexed_spaces, fn {space, index} -> space == :empty end)
            
        scored = Enum.map(empty_spaces, fn {space, index} -> 
            minimax(board, true)
            index
        end)

        Enum.max(scored)
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
            
            board_spaces = Board.current_marks(board)
            
            indexed_spaces = Enum.with_index(board_spaces)

            empty_spaces = Enum.filter(indexed_spaces, fn {space, index} -> space == :empty end)

            scored = Enum.map(empty_spaces, fn {space, index} -> 
                new_board = Board.update(board, index, "X")
                new_value = minimax(new_board, false)
            end)
            Enum.max(scored)
        end
    end

    def value(is_maximizing_player) when is_maximizing_player == true, do: 1
    def value(is_maximizing_player) when is_maximizing_player == false, do: -1

    def switch("X"), do: "O"
    def switch("O"), do: "X"

end