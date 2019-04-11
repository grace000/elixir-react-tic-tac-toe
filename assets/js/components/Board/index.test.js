import * as React from 'react'
import { shallow } from 'enzyme'
import Board from './index'
import Square from '../Square'

describe('Board Component', () => {
    const value = 0;
    const selectSquare = jest.fn(() => "mock called");

    const props = {
        value, selectSquare
    }

    const renderedComponent = shallow(<Square {...props} />);

    it(' renders <Square /> component ', () => {
        expect(renderedComponent.type()).toEqual('button')
    });

    it(' renders square component that handles click events', () => {
        renderedComponent.simulate('click')
        expect(selectSquare(value)).toBe("mock called")
        expect(selectSquare).toHaveBeenCalledTimes(1)
        expect(selectSquare).toHaveBeenCalledWith(0)
    });
});