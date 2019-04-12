defmodule TicTacToe.Board do
    def empty_board do
        %{}
    end

    def update(board, cell, player) do
        Map.put(board, cell, player)
    end

    def get_board_moves(board) do
        Enum.map(board, fn {key, _val} -> key end )
    end

    def current_marks(board) do
        Enum.map(0..8, fn x -> board[x] || :empty end)
    end

    def valid_move?(board, cell) do
        Map.get(board, cell) == nil
    end
end