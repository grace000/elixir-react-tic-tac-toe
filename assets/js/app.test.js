import * as React from 'react'
import * as ReactDOM from 'react-dom'
import Root from './Root'

it('renders without crashing', () => {
  const div = document.createElement('div');
  ReactDOM.render(<Root />, div);
  ReactDOM.unmountComponentAtNode(div);
});