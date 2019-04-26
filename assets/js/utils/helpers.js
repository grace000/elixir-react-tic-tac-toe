import axios from 'axios'

const helpers = {
    
    removeUnderscores(string) {
        const newString = string.replace(/_/g, " ");
        return newString
    },

    startNewGame(gameType) {
        return axios.get('/new_game/' + gameType)
            .then( response => {
                    return response.data
            }).catch(error => console.log(error));
    }

}

export default helpers; 

