import {search, topSearchStore} from './store';
import {useState} from '@hookstate/core';
import SearchListItem from './list-item';
import useInputIntervalHook from '../../lib/hooks/input-interval-hook';

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
    <div className="absolute top-0 mt-12 py-2 px-1 bg-yellow-300 w-64" style={{minHeight: '30rem'}}>
      {state.searches.get().map((identity) => {
        return (
          <div key={identity.publicKey} className="my-2">
            <SearchListItem identity={identity}/>
          </div>
        );
      })}
    </div>
  );
}
