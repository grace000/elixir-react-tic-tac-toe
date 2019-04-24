import * as React from 'react'
import * as ReactDOM from 'react-dom'
import Welcome from  './welcome'

it('renders without crashing', () => {
  const div = document.createElement('div');
  ReactDOM.render(<Welcome />, div);
  ReactDOM.unmountComponentAtNode(div);
});