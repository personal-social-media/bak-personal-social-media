import {search, topSearchStore} from './store';
import {useState} from '@hookstate/core';
import OutsideClickHandler from 'react-outside-click-handler';
import SearchListResultsFound from './list/results-found';
import useInputIntervalHook from '../../lib/hooks/input-interval-hook';

export default function SearchList({inputRef}) {
  const state = useState(topSearchStore);
  const listOpened = state.listOpened.get();
  const inputValue = state.inputValue.get();
  const localSearching = state.localSearching.get();
  const registrySearching = state.registrySearching.get();

  useInputIntervalHook(state.inputValue, 500, '', (val) => {
    if (!val || val.replace(/\s/g, '').length === 0) return;
    search(val, state);
  });

  function closeList(e) {
    if (!listOpened) return;
    if (inputValue.length < 1) return;

    const {current} = inputRef;
    const target = e?.target;
    if (current === target) return;
    state.merge({listOpened: false});
  }

  if (!listOpened || inputValue.length === 0) return null;

  return (
    <OutsideClickHandler onOutsideClick={closeList}>
      <div className="absolute top-0 mt-20 py-2 px-1 bg-white w-64 overflow-y-hidden">
        {
          (localSearching || registrySearching) ?
            (
              <div>
                Searching...
              </div>
            ) :
            (
              (state.localSearches.length > 0 || state.registrySearches.length > 0) ?
                (
                  <SearchListResultsFound state={state}/>
                ) :
                (
                  <div>
                    No result found
                  </div>
                )
            )
        }
      </div>
    </OutsideClickHandler>
  );
}
