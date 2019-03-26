import React, { Component } from 'react';
import Square from './square'
import axios from 'axios'

class Board extends Component {
    constructor(props) {
        super(props)
        this.state = {
            moves: []
        }

    }

    getBoardStatus() {
        axios.get('/boardstatus')
        .then((response) => {
            let data = JSON.stringify(response.data);
            console.log(data)
            this.setState({
                moves: data
            })
        }).catch(error => console.log(error))
    }

    renderSquare(i) {
        return (
          <Square
            value={this.props.squares[i]}
          />
        );
    }
    
    render() {
        return (
            <div>
                <p>{this.state.moves}</p>
                <button onClick={this.getBoardStatus.bind(this)}></button>
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