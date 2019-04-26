import * as React from 'react'
import * as ReactDOM from 'react-dom'
import { shallow } from 'enzyme'
import Welcome from  './welcome'
import Main from '../components/Main'

describe('Welcome component', () => {
  it('renders without crashing', () => {
    const div = document.createElement('div');
    ReactDOM.render(<Welcome />, div);
    ReactDOM.unmountComponentAtNode(div);
  });

  it(' renders welcome text', () => {
    const container = document.createElement('div');
    ReactDOM.render(<Welcome />, container);

    const heroText = container.querySelector('.phx-hero');

    expect(heroText.textContent).toBe("Welcome to Tic Tac Toe!");
  });

  it(' renders main component', () => {
      const wrapper = shallow(<Welcome />);

      expect(wrapper.containsMatchingElement(Main)).toEqual(true)
  });
})
