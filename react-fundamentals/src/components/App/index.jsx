import React, { Component } from "react";

import Series from "../../containers/Series";
import Routes from "../../routes";

import "./styles.css";

class App extends Component {
  render() {
    return (
      <div className="App">
        <header className="App-header">
          <h1>TV Series</h1>
        </header>
        <Routes />
      </div>
    );
  }
}

export default App;
