import * as React from 'react';

const Message = (props) => (
    <div className="message-box">
        <p>
            {props.message} please select a spot on the board!
        </p>
        <p>
            {props.error}
        </p>
    </div>
)
    


export default Message;
