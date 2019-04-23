defmodule TicTacToe.Game do
    alias __MODULE__

    alias TicTacToe.Board, as: Board
    alias TicTacToe.Rules, as: Rules
    
    defstruct [
        :game_status, 
        :current_player,
        :incoming_move, 
        :board,
        :game_type
    ]

    def setup_new_game(game_type) do
        %Game {
            game_type: game_type,
            game_status: "", 
            current_player: "X", 
            incoming_move: nil,
            board: Board.empty_board
        }
    end
    
    def make_move(game) do
        %{ 
          game | 
          board: Board.update(Board.parse_board(game.board), game.incoming_move, game.current_player),
          current_player: switch_player(game.current_player)
        }
    end

    def switch_player("X"), do: "O"

    def switch_player("O"), do: "X"

    def game_status(game) do
        %{
            game |
            game_status: Rules.status(game.board)
        }
    end
end