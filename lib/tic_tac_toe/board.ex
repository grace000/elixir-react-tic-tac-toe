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

    def current_marks(board) do
        Enum.map(0..8, fn x -> board[x] || :empty end)
    end
end