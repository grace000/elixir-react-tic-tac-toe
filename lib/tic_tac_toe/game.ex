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
        %{ game | 
            board: Board.update(game.board, game.incoming_move, game.current_player),
            current_player: switch_player(game.current_player)
        }
    end

    def switch_player("X" = player_token), do: "O"

    def switch_player("O" = player_token), do: "X"
end