defmodule TicTacToe.Game do
    alias __MODULE__

    alias TicTacToe.Board, as: Board
    alias TicTacToe.Rules, as: Rules
    alias TicTacToe.EasyComputer, as: EasyComputer

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

    def make_move(game, :easy_computer) do
        cond do
            game.game_status == :in_progress -> 
                %{ 
                    game | 
                    board: Board.update(game.board, EasyComputer.select_coordinate(Board.current_marks(game.board)), game.current_player),
                    current_player: switch_player(game.current_player)
                }
          true -> game
        end
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