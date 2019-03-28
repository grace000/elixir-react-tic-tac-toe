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

    componentDidMount() {
        axios.get('/boardstatus')
        .then((response) => {
            let data = response.data;
            let reduceData = Object.values(data)
            this.setState({
                moves: reduceData
            })
        }).catch(error => console.log(error))
    }

    handleClick(i) {
        const moves = this.state.moves.slice();
        moves[i] = "X";
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

    renderSquare(i) {
        
        return (
          <Square
            onClick={() => this.handleClick(i)}
            value={this.state.moves[i] || "-"}
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