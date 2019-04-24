import * as React from 'react'
import ReactDOM from 'react-dom'
import { shallow } from 'enzyme'
import Game from './game'
import Message from '../components/Message'
import Board from '../components/Board'

describe('Game Component', () => {
    it(' renders message component', () => {
        const wrapper = shallow(<Game />);

        expect(wrapper.containsMatchingElement(Message)).toEqual(true)
    })
    
    it(' renders board component', () => {
        const wrapper = shallow(<Game />);

        expect(wrapper.containsMatchingElement(Board)).toEqual(true)
    })
});