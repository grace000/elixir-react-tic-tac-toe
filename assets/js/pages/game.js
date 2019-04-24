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
        gameType: "",
        message: "Player one, please select a spot on the board!",
        error: ""
    }
}

componentDidMount() {
  
    axios.get('/new_game/' + this.props.location.state.message)
    .then((response) => {
        console.log(response)
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
    }).catch(error => console.log(error))
}

selectSquare(positionNumber) {
  this.postNewMark(positionNumber);
  this.removeErrorMessage()
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
          message: currentPlayer == "X" ? "Player one, please select a spot on the board!" : "Player two, please select a spot on the board!" 
      });
    }).catch(error => {
      const errorCode = error.response.status;
      const errorMessage = error.response.data;

      if(errorCode == 400) {
        this.setState({error: errorMessage});
      }
    });
}

removeErrorMessage() {
    this.setState({error: " "});
}
  render() {
    return (
      <div>
        <section className="phx-hero">
          <h1>Welcome to Tic Tac Toe!</h1>
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