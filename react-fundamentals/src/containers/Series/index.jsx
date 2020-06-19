import React, { Component } from 'react';

import 'whatwg-fetch';

import Intro from "../../components/Intro";
import SeriesList from '../../components/SeriesList';
import Loader from '../../components/Loader';


class Series extends Component {
  state = {
    series: [],
    seriesName: '',
    isFetching: false
  };

  handleInputChange = e => {
    this.setState({ seriesName: e.target.value, isFetching: true })
    fetch(`http://api.tvmaze.com/search/shows?q=${e.target.value}`)
      .then((response) => response.json())
      .then((json) => this.setState({ series: json, isFetching: false }));
  }

  render() {
    const { series, seriesName, isFetching } = this.state;
    return (
      <div>
        <div>
          <Intro message="Here you can find all of your most loved series" />
          <input type="text" onChange={this.handleInputChange}/>
        </div>
        {
          series.length === 0 && seriesName.trim() === '' && !isFetching
          && <p>Please enter series name into the input</p>
        }
        {
          series.length === 0 && seriesName.trim() !== '' && !isFetching
          && <p>No TV series have been found  with this name</p>
        }
        {
          isFetching ? <Loader /> : <SeriesList list={series}/>
        }
      </div>
    )
  }
}

export default Series;