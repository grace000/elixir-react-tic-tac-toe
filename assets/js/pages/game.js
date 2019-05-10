import Board from '../components/Board';
import Message from '../components/Message';
import React, { Component } from 'react';
import axios from 'axios'
import gameInfo from '../components/GameInfo';
import helpers from '../utils/helpers'

class Game extends Component {
  constructor(props) {
    super(props);
    this.state = {
      moves: {},
      currentPlayer: "",
      gameStatus: "",
      winningCoordinates: [],
      message: gameInfo.takeTurnMessage.playerOne,
      error: ""
    }
  }

  componentDidMount() {
    helpers.startNewGame(this.props.location.state.message).then(data => {
      this.setState({
        gameStatus: data.game_status,
        winningCoordinates: data.winning_coordinates,
        moves: Object.assign(this.state.moves, data.board),
        currentPlayer: data.current_player,
        gameType: data.game_type
      })
    })
  }

  selectSquare(positionNumber) {
    switch(this.state.gameStatus) {
      case "winner":
        return;
      default: 
        this.postNewMark(positionNumber);
        this.removeErrorMessage();
    }
  }

  winningSquare(positionNumber) {
    switch(this.state.gameStatus){
      case "winner":
        return this.highlightSquare(positionNumber);
      default: 
        return "regular-square";
    }
  }

  highlightSquare(positionNumber) {
    let squareClass = "regular-square";
    this.state.winningCoordinates.forEach(coord => {
      if (coord === positionNumber) {
        squareClass = "winning-square";
      }
    })
    return squareClass;
  }

  postNewMark(requestedMove) {
    helpers.makeBoardMarkRequest(
      this.state.moves, 
      this.state.gameStatus, 
      this.state.currentPlayer,
      this.state.winningCoordinates,
      requestedMove,
      this.state.gameType
      ).then((response) => {
        this.setState({
          gameStatus: response.game_status,
          moves: Object.assign(this.state.moves, response.board),
          winningCoordinates: response.winning_coordinates,
          currentPlayer: response.current_player,
          message: response.current_player == gameInfo.playerOne.token ? gameInfo.takeTurnMessage.playerOne : gameInfo.takeTurnMessage.playerTwo
        });
    }).catch(error => {
      const errorCode = error.response.status;
      const errorMessage = error.response.data;

      if (errorCode == 400) {
        this.setState({ error: errorMessage });
      }
    });
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
        winner={currentPlayer == gameInfo.playerOne ? gameInfo.playerTwo.name : gameInfo.playerOne.name}
      />

    const gameInProgress =
      <Message
        message={message}
        error={error}
        status={""}
      />

    return (
      <div>
        <section className="phx-hero">
          <h1>{helpers.removeUnderscores(this.props.location.state.message).toUpperCase()} GAME</h1>
        </section>
        <section> 
          { this.displayStatus(gameStatus) ? gameOver : gameInProgress }
        </section>
        <section>
          <Board 
            moves={moves}
            selectSquare={(positionNumber) => this.selectSquare(positionNumber)}
            winningSquare={(positionNumber) => this.winningSquare(positionNumber)}
          />
        </section>
      </div>
    );
  }
}

export default Game;