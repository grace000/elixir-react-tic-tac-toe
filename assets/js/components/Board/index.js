import React, { Component } from 'react';
import Square from '../Square'
import Message from '../Message'
import axios from 'axios'

class Board extends Component {
    constructor(props) {
        super(props)
        this.state = {
            gameStatus: "",
            moves: [],
            currentPlayer: "",
            message: "Player one,",
            error: ""
        }
    }

    componentDidMount() {
        axios.get('/newgame')
        .then((response) => {
            let data = response.data;
            let boardData = data.board;
            let currentPlayer = data.current_player;
            let gameStatus = data.game_status;
            let reduceBoard = Object.values(boardData)
            this.setState({
                gameStatus: gameStatus,
                moves: reduceBoard,
                currentPlayer: currentPlayer,
            })
        }).catch(error => console.log(error))
    }

    getCurrentPlayer() {
        if (this.state.currentPlayer == "X") {
            this.setState({
                currentPlayer: "O",
                message: "Player two,"
            })
            return "X"
        } 
        else {
            this.setState({
                currentPlayer: "X",
                message: "Player one,"
            })
            return "O"
        }
            
    }

    removeErrorMessage() {
        this.setState({error: " "});
    }

    selectSquare(positionNumber) {
        const moves = this.state.moves.slice();
        if (moves[positionNumber] == null) {
            moves[positionNumber] = this.getCurrentPlayer();
            this.postNewMark(positionNumber);
        }
        else {
            this.setState({error: "Oh no, select an empty space!"});
            setTimeout(()=> this.removeErrorMessage(), 1000);
        }
    }

    postNewMark(requestedMove) {
        axios.post('/api/createmove', {
            headers: {"Content-Type": "application/json"},
            data: {
                board: this.state.moves,
                gameStatus: this.state.gameStatus,
                currentPlayer: this.state.currentPlayer,
                incomingMove: requestedMove
            }
        })
        .then((response) => {
            let data = response.data;
            let boardData = data.board;
            let gameStatus = data.game_status;
            let reduceBoard = Object.values(boardData)
            this.setState({
                gameStatus: gameStatus,
                moves: reduceBoard
            })
        }).catch(error => console.log(error));
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