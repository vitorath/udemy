import React from 'react';
import { Route } from 'react-router-dom';

import UserForm from './pages/User/Form';
import UserList from './pages/User/List';

function Routes() {
  return (
    <>
      <Route path="/" exact component={UserList} />
      <Route path="/form" exact component={UserForm} />
    </>
  );
}

export default Routes;