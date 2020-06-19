import React from 'react';
import { Link } from 'react-router-dom';

import './styles.css';

const SeriesListItem = ({ serie }) => (
  <li>
    <Link to={`/series/${serie.show.id}`}>
      {serie.show.name}
    </Link>
  </li> 
); 

const SeriesList = (props) => {
  return (
    <ul className="series-list">
      {props.list.map((serie) => (
        <SeriesListItem key={serie.show.id} serie={serie} />
      ))}
    </ul>
  );
}

export default SeriesList;