import {forwardRef} from 'react';
import {topSearchStore} from './store';
import {useState} from '@hookstate/core';

export const TopSearchInput = forwardRef((_, ref) => { // eslint-disable-line react/display-name
  const state = useState(topSearchStore);
  const inputValue = state.inputValue.get();

  function type(e) {
    const {value} = e.target;
    state.merge({inputValue: value, listOpened: true});
  }

  function open() {
    if (inputValue.length < 1) {
      return;
    }
    state.merge({listOpened: true});
  }

  return (
    <form className="pure-form">
      <input type="text" placeholder="Search" className="bg-yellow-200 w-48 focus:w-64 text-gray-700" onChange={type} onFocus={open} ref={ref}/>
    </form>
  );
});
