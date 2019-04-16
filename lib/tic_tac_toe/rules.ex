defmodule TicTacToe.Rules do
    alias TicTacToe.Board, as: Board
    
    @players ["X", "O"]
    
    def in_progress?(board), do: status(board) == "in progress"

    def status(board), do: board_state(Board.current_marks(board))
    
    defp board_state([x, x, x,
                      _, _, _,
                      _, _, _]) when x in @players, do: {x, [0,1,2]}
    
    defp board_state([_, _, _,
                      x, x, x,
                      _, _, _]) when x in @players, do: {x, [3,4,5]}
                     
    defp board_state([_, _, _,
                      _, _, _,
                      x, x, x,]) when x in @players, do: {x, [6,7,8]}
    
    defp board_state([x, _, _,
                      _, x, _,
                      _, _, x,]) when x in @players, do: {x, [0,4,8]} 

    defp board_state([_, _, x,
                      _, x, _,
                      x, _, _,]) when x in @players, do: {x, [2,4,6]} 

    defp board_state([x, _, _,
                      x, _, _,
                      x, _, _,]) when x in @players, do: {x, [0,3,6]} 

    defp board_state([_, x, _,
                      _, x, _,
                      _, x, _,]) when x in @players, do: {x, [1,4,7]} 
    
    defp board_state([_, _, x,
                      _, _, x,
                      _, _, x,]) when x in @players, do: {x, [2,5,8]}
    
    defp board_state(current_marks) do
        if Enum.member?(current_marks, :empty) do
            "in progress"
        else
            "draw"
        end
    end
end