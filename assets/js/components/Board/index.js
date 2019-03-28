import React, { Component } from 'react';
import Square from '../Square'
import axios from 'axios'

class Board extends Component {
    constructor(props) {
        super(props)
        this.state = {
            moves: Array(9)
        }
    }

    selectSquare(position_number) {
        const moves = this.state.moves.slice();
        moves[position_number] = "X";
        this.setState({
            moves: moves
        });
        this.postNewMark()
    }

    postNewMark() {
        axios.post('/api/boardstatus', {
            headers: {"Content-Type": "application/json"},
            data: {
                moves: this.state.moves
            }
        });
    }

    renderSquare(position_number) {
        
        return (
          <Square
            onClick={() => this.selectSquare(position_number)}
            value={this.state.moves[position_number] || "-"}
          />
        );
    }
    
    render() {
        return (
            <div>
                <div className="board-row">
                    {this.renderSquare(0)}
                    {this.renderSquare(1)}
                    {this.renderSquare(2)}
                </div>
                <div className="board-row">
                    {this.renderSquare(3)}
                    {this.renderSquare(4)}
                    {this.renderSquare(5)}
                </div>
                <div className="board-row">
                    {this.renderSquare(6)}
                    {this.renderSquare(7)}
                    {this.renderSquare(8)}
                </div>
            </div>
        );
    }
}

export default Board;