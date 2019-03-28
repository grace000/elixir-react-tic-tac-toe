import * as React from 'react'
import { shallow } from 'enzyme'
import Square from './index'


describe('Square Component', () => {
    it(' should receive props and then render text', () => {
        const wrapper = shallow(<Square value="X"/>);

        expect(wrapper.text()).toBe("X");
    });
});