defmodule TicTacToe.Game do
    alias __MODULE__

    alias TicTacToe.Board, as: Board
    
    defstruct [:game_status, :player_one, :player_two, :current_player, :board]

    def setup_new_game do
       %Game{game_status: "in progress", 
              player_one: "X",
              player_two: "O",
              current_player: "X",
              board: Board.empty_board}
    end

    def make_move(game, position, player) do
        %{ game | board: Board.update(game.board, position, player)}
    end
end