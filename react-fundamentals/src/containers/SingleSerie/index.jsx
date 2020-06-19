import React, { Component, Fragment } from 'react';
import { Link } from 'react-router-dom';

import 'whatwg-fetch';

import Loader from '../../components/Loader';


class SingleSerie extends Component {
  state = {
    show: null
  }

  componentDidMount() {
    const { id } = this.props.match.params;
    fetch(`http://api.tvmaze.com/shows/${id}?embed=episodes`)
      .then((response) => response.json())
      .then((json) => this.setState({ show: json }));
  }

  render() {
    const { show } = this.state;

    return (
      <div>
        <p>
          <Link to="/">Go back</Link>
        </p>
        {
          show === null && <Loader /> 
        }
        {
          show !== null && (
            <Fragment>
              <p>{show.name}</p>
              <p>Premiered - {show.premiered}</p>
              <p>Rating - {show.rating.average}</p>
              <p>Episodes {show._embedded.episodes.length}</p>
              <img alt={show.name} src={show.image.medium} />
            </Fragment>
          )
        }
      </div>
    )
  }
}

export default SingleSerie;