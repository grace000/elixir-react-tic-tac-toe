import * as React from 'react'
import ReactDOM from 'react-dom'
import { shallow, mount } from 'enzyme'
import Game from './game'
import Main from '../components/Main'
import Message from '../components/Message'
import Board from '../components/Board'

describe('Game Component', () => {
    it(' renders welcome text', () => {
        const container = document.createElement('div');
        ReactDOM.render(<Game />, container);

        const heroText = container.querySelector('.phx-hero');

        expect(heroText.textContent).toBe("Welcome to Tic Tac Toe!");
    })

    it(' renders main component', () => {
        const wrapper = shallow(<Game />);

        expect(wrapper.containsMatchingElement(Main)).toEqual(true)
    })

    it(' renders message component', () => {
        const wrapper = shallow(<Game />);

        expect(wrapper.containsMatchingElement(Message)).toEqual(true)
    })
    
    it(' renders board component', () => {
        const wrapper = shallow(<Game />);

        expect(wrapper.containsMatchingElement(Board)).toEqual(true)
    })
});