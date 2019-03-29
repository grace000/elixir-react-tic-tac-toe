import Main from '../components/Main';
import Board from '../components/Board';
import React, { Component } from 'react';

class HomePage extends Component {
  constructor(props) {
    super(props);
      this.state = {
        squares: Array(9)
      }
  }


  render() {
    return (
      <div>
        <Main>
          <section className="phx-hero">
            <h1>Welcome to Tic Tac Toe!</h1>
          </section>
          <section>
            <Board squares={this.state.squares}/>
          </section>
        </Main>
      </div>
    );
  }
}

export default HomePage;