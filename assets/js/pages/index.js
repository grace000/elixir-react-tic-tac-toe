import Main from '../components/Main';
import Board from '../components/Board';
import Message from '../components/Message';
import React, { Component } from 'react';
import axios from 'axios'
import gameInfo from '../components/GameInfo';

class Game extends Component {
  constructor(props) {
    super(props);
    this.state = {
      moves: {},
      currentPlayer: "",
      gameStatus: "",
      message: gameInfo.takeTurnMessage.playerOne,
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
      }).catch(error => console.log(error));
  }

  selectSquare(positionNumber) {
    this.postNewMark(positionNumber);
    this.removeErrorMessage();
  }

  postNewMark(requestedMove) {
    axios.post('/api/create_move', {
      headers: { "Content-Type": "application/json" },
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
        message: currentPlayer == gameInfo.playerOne ? gameInfo.takeTurnMessage.playerOne : gameInfo.takeTurnMessage.playerTwo
      });
    }).catch(error => {
      let errorCode = error.response.status;
      let errorMessage = error.response.data;

      if (errorCode == 400) {
        this.setState({ error: errorMessage });
      }
    }
    );
  }

  removeErrorMessage() {
    this.setState({ error: " " });
  }

  displayStatus(status) {
    return status == "winner" || status == "draw";
  }

  render() {
    const { gameStatus, currentPlayer, message, error, moves } = this.state;

    const gameOver =
      <Message
        message={""}
        error={""}
        status={gameStatus}
        winner={currentPlayer == gameInfo.playerOne ? gameInfo.playerTwo : gameInfo.playerOne}
      />

    const gameInProgress =
      <Message
        message={message}
        error={error}
        status={""}
      />

    return (
      <div>
        <Main>
          <section className="phx-hero">
            <h1>Welcome to Tic Tac Toe!</h1>
          </section>
          <section>
            {this.displayStatus(gameStatus) ? gameOver : gameInProgress}
          </section>
          <section>
            <Board
              moves={moves}
              selectSquare={(positionNumber) => this.selectSquare(positionNumber)}
            />
          </section>
        </Main>
      </div>
    );
  }
}

export default Game;