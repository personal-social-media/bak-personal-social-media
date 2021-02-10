import {forwardRef} from 'react';
import {topSearchStore} from './store';
import {useEffect} from 'react';
import {useState} from '@hookstate/core';

export const TopSearchInput = forwardRef((_, ref) => { // eslint-disable-line react/display-name
  const state = useState(topSearchStore);

  function type(e) {
    const {value} = e.target;
    state.merge({inputValue: value, listOpened: true});
  }

  function open() {
    state.merge({listOpened: true});
  }

  useEffect(() => {
    return () => {
      state.merge({inputValue: '', listOpened: false});
    };
  }, []); // eslint-disable-line react-hooks/exhaustive-deps

  return (
    <form className="pure-form">
      <input name="query" type="text" placeholder="Search" className="bg-yellow-200 w-48 focus:w-64 text-gray-700" onChange={type} onFocus={open} ref={ref}/>
    </form>
  );
});
