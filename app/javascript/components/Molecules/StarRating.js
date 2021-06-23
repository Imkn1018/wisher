import React,{useState} from 'react';
import ReactDOM from 'react-dom';

import ReactStarsRating from 'react-awesome-stars-rating';


function ReactStarsExample({ value }) {
  const [star, setStar] = useState(1)
  const onChange = (value) => {
  console.log(`React Stars Rating value is ${value}`);
  setStar(value)
};
  return <ReactStarsRating onChange={onChange} value={star} />;
};

export default ReactStarsExample;