import * as React from 'react';

const Status = ({ status, winner }) => {
    if (status == "winner") {
      return (
        <div className="winner">
          {winner} is the {status}
        </div>
      );
    }
    else if (status == "draw") {
        return (
            <div className="draw">
              Draw Game!!
            </div>
        );
    }
    else return null;
  };

export default Status;

  