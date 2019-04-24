import React, { Component } from 'react';
import Main from '../components/Main';
import Square from '../components/Square';

class Welcome extends Component {
    constructor(props) {
      super(props);
    }

    removeUnderscores(string) {
        const newString = string.replace(/_/g, " ");
        return newString
    }

    handleGameSelection(gameType) {
        this.props.history.push({pathname: '/new_game', state: {message: gameType}});
    }

    renderGameSelectSquare(gameType) {

        return (
          <Square
            onClick={() => this.handleGameSelection(gameType)}
            value={this.removeUnderscores(gameType)}
          />
        );
    }

    render() {
        return (
            <div>
              <Main>
                <section className="phx-hero">
                  <h1>Welcome to Tic Tac Toe!</h1>
                </section>
                <section className="game-selection">
                  <div>
                    {this.renderGameSelectSquare("human_vs_human")}
                    {this.renderGameSelectSquare("easy_computer")}
                  </div>
                </section>
              </Main>
            </div>
        )
    };

}

export default Welcome;