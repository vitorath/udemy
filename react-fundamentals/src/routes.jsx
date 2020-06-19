import React from 'react';
import { Switch, Route } from 'react-router-dom';

import Series from './containers/Series';
import SingleSerie from './containers/SingleSerie';

const src = () => {
  return (
    <Switch>
      <Route exact path="/" component={Series} />
      <Route exact path="/series/:id" component={SingleSerie} />
    </Switch>
  );
}

export default src;