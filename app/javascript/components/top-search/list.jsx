import {topSearchStore, search} from './store';
import {useState} from '@hookstate/core';
import useInputIntervalHook from '../../lib/hooks/input-interval-hook';
import SearchListItem from "./list-item";

export default function SearchList() {
  const state = useState(topSearchStore);
  const inputValue = state.inputValue.get();

  useInputIntervalHook(state.inputValue, 500, '', (val) => {
    search(val, state);
  });

  if (inputValue === '') {
    return null;
  }

  return (
    <div className="absolute top-0 mt-12 py-2 px-1 bg-yellow-300 w-64" style={{minHeight: '10rem'}}>
      {state.searches.get().map((identity) => {
        return(
          <SearchListItem identity={identity} key={identity.publicKey}/>
        )
      })}
    </div>
  );
}
