import * as React from 'react'
import { shallow, mount } from 'enzyme'
import Game from './index'

describe('HomePage Component', () => {
    it('renders', () => {
        const wrapper = shallow(<Game />);

        expect(wrapper.exists()).toBe(true);
    });
});