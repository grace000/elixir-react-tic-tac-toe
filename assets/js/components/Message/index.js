import * as React from 'react';
import Status from './status'

const Message = (props) => (
  <div className="message-box">
    <p>
      {props.message}
    </p>
    <p>
      {props.error}
    </p>
    <Status 
      status={props.status}
      winner={props.winner}
    />
  </div>
)

export default Message;
