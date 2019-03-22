defmodule TicTacToe.Board do
    def empty_board do
        %{}
    end

    def update(board, cell, player) do
        Map.put(board, player, cell)
    end

    def get_board_moves(board) do
        Enum.map(board, fn {_key, val} -> val end )
    end
end