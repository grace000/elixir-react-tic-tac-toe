import React, { Component } from 'react';
import Square from '../Square'
import Message from '../Message'
import axios from 'axios'

class Board extends Component {
    constructor(props) {
        super(props)
        this.state = {
            moves: Array(9),
            current_player: " ",
            message: "Player one,",
            error: " "
        }
    }

    getCurrentPlayer() {
        if (this.state.current_player == "X") {
            this.setState({
                current_player: "O",
                message: "Player one,"
            })
            return "O"
        } 
        else {
            this.setState({
                current_player: "X",
                message: "Player two,"
            })
            return "X"
        }
            
    }

    removeErrorMessage() {
        this.setState({error: " "});
    }

    selectSquare(position_number) {
        const moves = this.state.moves.slice();
        
        if (moves[position_number] == null) {
            moves[position_number] = this.getCurrentPlayer();
                this.setState({
                    moves: moves
                });
                this.postNewMark();
        }
        else {
            this.setState({error: "Oh no, select an empty space!"});
            setTimeout(()=> this.removeErrorMessage(), 1000);
        }
    }

    postNewMark() {
        axios.post('/api/createmove', {
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
                <section className="message-box">
                    <Message message={this.state.message} error={this.state.error}/>
                </section>
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