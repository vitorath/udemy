import React, { Component } from 'react';

import './styles.css';

class UserList extends Component {

  constructor(props) {
    super(props);
    this.state = {
      users: []
    }
  }

  componentDidMount() {
    fetch('http://localhost:8080/usuario')
      .then(response => response.json())
      .then(json => this.setState({ users: json}))
  }

  render() {
    return (
      <table className="UserList">
        <thead>
          <tr>
            <th>id</th>
            <th>Nome</th>
            <th>E-mail</th>
          </tr>
        </thead>
        <tbody>
          {this.state.users.map(user => (
            <tr>
              <td>{user.id}</td>
              <td>{user.nome}</td>
              <td>{user.email}</td>
            </tr>
          ))}
        </tbody>
      </table>
    )
  }
}

export default UserList;