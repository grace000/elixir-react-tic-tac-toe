import * as React from 'react';

const Status = ({ status, winner }) => {
  switch (status){
    case "winner":
      return (
        <div className="winner">
          {winner} is the {status}
        </div>
      );
    case "draw":
      return (
        <div className="draw">
          Draw Game!!
        </div>
      );
    default:
      return null;
  }
} 

export default Status;

  