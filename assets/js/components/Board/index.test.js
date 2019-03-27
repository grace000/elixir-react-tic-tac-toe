import * as React from 'react'
import { shallow } from 'enzyme'
import Board from './index'

describe('Board Component', () => {
    it(' first board-row should return three Square components', ()=> {
        const wrapper = shallow(<Board />);
        
        expect(wrapper.find('.board-row').first().text()).toBe("<Square /><Square /><Square />");
    });
});