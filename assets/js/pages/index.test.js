import * as React from 'react'
import { shallow, mount } from 'enzyme'
import HomePage from './index'

describe('HomePage Component', () => {
    it('renders', () => {
        const wrapper = shallow(<HomePage />);

        expect(wrapper.exists()).toBe(true);
    });
});