import * as React from 'react'
import { shallow } from 'enzyme'
import Message from './index'

describe('Message', () => {
    it('renders message component', () => {
        const wrapper = shallow(<Message />);

        expect(wrapper.exists()).toBe(true);
    });
});