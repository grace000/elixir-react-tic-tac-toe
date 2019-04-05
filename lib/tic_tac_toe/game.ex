defmodule TicTacToe.Game do
    alias __MODULE__

    alias TicTacToe.Board, as: Board
    
    defstruct [:game_status, 
               :current_player,
               :incoming_move, 
               :board]

    def setup_new_game do
       %Game{game_status: "in progress", 
              current_player: "X",
              incoming_move: nil,
              board: Board.empty_board}
    end

    def make_move(game) do
        %{ game | board: Board.update(game.board, game.incoming_move, game.current_player)}
    end
end