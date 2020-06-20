import React from "react";
import { BrowserRouter, Link } from "react-router-dom";
import { Provider } from "react-redux";

import Routes from "../routes";
import store from "../store";

import './styles.css';

function App() {
  return (
    <Provider store={store} >
      <BrowserRouter>
        <div className="App">
          <header>
            <Link to="/">Listar</Link>
            <Link to="/form">Cadastrar</Link>
          </header>
          <Routes />
        </div>
      </BrowserRouter>
    </Provider>
  );
}

export default App;
