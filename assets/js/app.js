import * as React from 'react';
import * as ReactDOM from 'react-dom';
import Root from './Root';

// The MiniCssExtractPlugin is used to separate it out into
// its own CSS file.
import css from "../css/app.css"
import "phoenix_html"


// This code starts up the React app when it runs in a browser. It sets up the routing
// configuration and injects the app into a DOM element.
ReactDOM.render(<Root />, document.getElementById('react-app'));