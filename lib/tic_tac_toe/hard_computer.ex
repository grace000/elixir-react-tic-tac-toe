defmodule TicTacToe.HardComputer do

    alias TicTacToe.Board, as: Board
    alias TicTacToe.Rules, as: Rules

    def select_coordinate(board) do
        minimax(board, true)
    end
    
    def minimax(board, is_maximizing_player) do
        case Rules.status(board) do
            :winner -> value(is_maximizing_player)
            :draw -> 0
        end

        if is_maximizing_player do
            value = -1000 
            
            board_spaces = Board.current_marks(board)
            |> Enum.with_index
            |> Enum.map(fn {space, index} -> 
                new_board = Board.update(board, index, "X")
                new_value = Enum.max(value, minimax(new_board, true))
            end)
            new
        end
    end

    def value(is_maximizing_player) when is_maximizing_player == true, do: 1
    def value(is_maximizing_player) when is_maximizing_player == false, do: -1

    def switch("X"), do: "O"
    
    def switch("O"), do: "X"

end