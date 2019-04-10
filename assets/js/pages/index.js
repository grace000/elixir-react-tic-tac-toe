import Main from '../components/Main';
import Board from '../components/Board';
import Message from '../components/Message';
import React, { Component } from 'react';
import axios from 'axios'

class Game extends Component {
  constructor(props) {
    super(props);
    this.state = {
        moves: {},
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

    if (!moves[positionNumber]) {
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
  render() {
    return (
      <div>
        <Main>
          <section className="phx-hero">
            <h1>Welcome to Tic Tac Toe!</h1>
          </section>
          <section>
            <Message message={this.state.message} error={this.state.error}/>
          </section>
          <section>
            <Board 
              moves={this.state.moves}
              selectSquare={(positionNumber) => this.selectSquare(positionNumber)}
            />
          </section>
        </Main>
      </div>
    );
  }
}

export default Game;