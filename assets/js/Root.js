import * as React from 'react';
import { BrowserRouter, Route, Switch } from 'react-router-dom';

import Header from './components/Header';
import Welcome from './pages/welcome';
import Game from './pages/game';

const Root = () => (
  <>
    <Header />
    <BrowserRouter>
      <Switch>
        <Route exact path="/" component={Welcome} />
        <Route exact path="*" component={Game}/>
      </Switch>
    </BrowserRouter>
  </>
);

export default Root;