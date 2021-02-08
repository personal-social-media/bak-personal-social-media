import {topSearchStore} from './store';
import {useState} from '@hookstate/core';

export default function TopSearchInput() {
  const state = useState(topSearchStore);

  function type(e) {
    const {value} = e.target;
    state.merge({inputValue: value, listOpened: true});
  }

  function open(){
    state.merge({listOpened: true});
  }

  return (
    <form className="pure-form">
      <input type="text" placeholder="Search" className="bg-yellow-200 w-48 focus:w-64 text-gray-700" onChange={type} onFocus={open}/>
    </form>
  );
}
