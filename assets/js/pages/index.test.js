import * as React from 'react'
import ReactDOM from 'react-dom'
import { shallow, mount } from 'enzyme'
import Game from './index'
import Main from '../components/Main'

describe('Game Component', () => {
    it(' renders welcome text', () => {
        const container = document.createElement('div');
        ReactDOM.render(<Game />, container);

        const heroText = container.querySelector('.phx-hero');

        expect(heroText.textContent).toBe("Welcome to Tic Tac Toe!");
    })
});