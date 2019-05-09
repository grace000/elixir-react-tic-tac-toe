import * as React from 'react';

const Square = (props) => (
  <button className={props.status} onClick={props.onClick}>
    {props.value}
  </button>
)

export default Square;
