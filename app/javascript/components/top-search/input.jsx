import {forwardRef} from 'react';
import {iconStyle, inputStyle} from './input.module.scss';
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
    <form className="pure-form relative">
      <input name="query" type="text" placeholder="Search" className={`bg-white w-48 focus:w-64 text-gray-700 ${inputStyle}`} onChange={type} onFocus={open} ref={ref}/>
      <i className={`fa fa-search absolute cursor-text text-gray-700 ${iconStyle}`} onClick={() => ref.current.focus()}/>
    </form>
  );
});
