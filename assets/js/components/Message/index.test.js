import * as React from 'react'
import { shallow } from 'enzyme'
import Message from './index'

describe('Message', () => {
    it('renders message component', () => {
        const wrapper = shallow(<Message />);

        expect(wrapper.exists()).toBe(true);
    });

    it(' renders player message', () => {
        const wrapper = shallow(<Message message={"Player One"} />);

        expect(wrapper.text()).toBe("Player One please select a spot on the board!");
    })

    it(' renders error message', () => {
        const wrapper = shallow(<Message error={"Oh no, select another spot"} />);

        expect(wrapper.text()).toBe(" please select a spot on the board!Oh no, select another spot");
    })
});