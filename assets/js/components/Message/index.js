import * as React from 'react';

const Message = (props) => (
  <div className="message-box">
    <p>
      {props.message}
    </p>
    <p>
      {props.error}
    </p>
    <p>
      {props.status}
    </p>
  </div>
)

export default Message;
