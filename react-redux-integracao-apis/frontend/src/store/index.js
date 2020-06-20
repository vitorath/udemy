import { createStore, applyMiddleware } from 'redux';
import reduxThunk from 'redux-thunk';

import rootReducers from './reducers';

export default createStore(rootReducers, {}, applyMiddleware(reduxThunk))