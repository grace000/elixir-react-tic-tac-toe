import axios from 'axios'

const helpers = {
    
    removeUnderscores(string) {
        const newString = string.replace(/_/g, " ");
        return newString
    },

    startNewGame(gameType) {
        return axios.get('/new_game/' + gameType)
            .then(response => {
                    return response.data
            }).catch(error => console.log(error));
    },

    makeBoardMarkRequest(moves, gameStatus, currentPlayer, incomingMove, gameType) {
        return axios.post('/api/create_move', {
            headers: {"Content-Type": "application/json"},
            data: {
                board: moves,
                gameStatus: gameStatus,
                currentPlayer: currentPlayer,
                incomingMove: incomingMove,
                gameType: gameType
            }
        }).then(response => {
            return response.data
        })
    }

}

export default helpers; 

