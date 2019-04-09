import Main from '../components/Main';
import Board from '../components/Board';
import React, { Component } from 'react';
import axios from 'axios'

class HomePage extends Component {

  render() {
    return (
      <div>
        <Main>
          <section className="phx-hero">
            <h1>Welcome to Tic Tac Toe!</h1>
          </section>
          <section>
            <Board />
          </section>
        </Main>
      </div>
    );
  }
}

export default HomePage;