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
  
    axios.get('/new_game/' + this.props.location.state.message)
    .then((response) => {
        const data = response.data;
        const boardData = data.board;
        const currentPlayer = data.current_player;
        const gameStatus = data.game_status;
        const gameType = data.game_type;
        this.setState({
            gameStatus: gameStatus,
            moves: Object.assign(this.state.moves, boardData),
            currentPlayer: currentPlayer,
            gameType: gameType
        })
      }).catch(error => console.log(error));
  }

  selectSquare(positionNumber) {
    this.postNewMark(positionNumber);
    this.removeErrorMessage();
  }

  postNewMark(requestedMove) {
    axios.post('/api/create_move', {
        headers: {"Content-Type": "application/json"},
        data: {
            board: this.state.moves,
            gameStatus: this.state.gameStatus,
            currentPlayer: this.state.currentPlayer,
            incomingMove: requestedMove,
            gameType: this.state.gameType
        }
    }).then((response) => {
      const data = response.data;
      const boardData = data.board;
      const gameStatus = data.game_status;
      const currentPlayer = data.current_player;
      this.setState({
        gameStatus: gameStatus,
        moves: Object.assign(this.state.moves, boardData),
        currentPlayer: currentPlayer,
        message: currentPlayer == gameInfo.playerOne ? gameInfo.takeTurnMessage.playerOne : gameInfo.takeTurnMessage.playerTwo
      });
    }).catch(error => {
      const errorCode = error.response.status;
      const errorMessage = error.response.data;

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

removeUnderscores(string) {
  const newString = string.replace(/_/g, " ");
  return newString
}

removeErrorMessage() {
    this.setState({error: " "});
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
        <section className="phx-hero">
          <h1>{this.removeUnderscores(this.props.location.state.message)} game</h1>
        </section>
        <section> 
          { (this.state.gameStatus == "winner" || this.state.gameStatus == "draw") ? 
            <Message 
              message={""} 
              error={""} 
              status={this.state.gameStatus}
              winner={this.state.currentPlayer == "X" ? "O" : "X"} 
              /> : 
              <Message 
                message={this.state.message}
                error={this.state.error}
                status={""}
              /> 
            }
        </section>
        <section>
          <Board 
            moves={this.state.moves}
            selectSquare={(positionNumber) => this.selectSquare(positionNumber)}
          />
        </section>
      </div>
    );
  }
}

export default Game;