import React, { Component } from 'react';
import Square from '../Square'
import Message from '../Message'
import axios from 'axios'

class Board extends Component {
    constructor(props) {
        super(props)
        this.state = {
            moves:{},
            currentPlayer:"",
            gameStatus: "",
            message: "Player one,",
            error: ""
        }
    }

    componentDidMount() {
        axios.get('/new_game')
        .then((response) => {
            let data = response.data;
            let boardData = data.board;
            let currentPlayer = data.current_player;
            let gameStatus = data.game_status;
            this.setState({
                gameStatus: gameStatus,
                moves: Object.assign(this.state.moves, boardData),
                currentPlayer: currentPlayer,
            })
        }).catch(error => console.log(error))
    }

    selectSquare(positionNumber) {
        const moves = this.state.moves;
    
        if (moves[positionNumber] == null) {
            moves[positionNumber] = this.state.currentPlayer;
            this.postNewMark(positionNumber);
        } else {
            this.setState({error: "Oh no, select an empty space!"});
            setTimeout(()=> this.removeErrorMessage(), 1000);
        }
    }
    
    postNewMark(requestedMove) {
        axios.post('/api/create_move', {
            headers: {"Content-Type": "application/json"},
            data: {
                board: this.state.moves,
                gameStatus: this.state.gameStatus,
                currentPlayer: this.state.currentPlayer,
                incomingMove: requestedMove
            }
        }).then((response) => {
            let data = response.data;
            let boardData = data.board;
            let gameStatus = data.game_status;
            let currentPlayer = data.current_player;
            this.setState({
                gameStatus: gameStatus,
                moves: Object.assign(this.state.moves, boardData),
                currentPlayer: currentPlayer,
                message: currentPlayer == "X" ? "Player one," : "Player two," 
            });
        }).catch(error => console.log(error));
    }
    
    removeErrorMessage() {
        this.setState({error: " "});
    }

    renderSquare(positionNumber) {
        
        return (
          <Square
            onClick={() => this.selectSquare(positionNumber)}
            value={this.state.moves[positionNumber] || "-"}
          />
        );
    }
    
    render() {
        return (
            <div>
                <section>
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