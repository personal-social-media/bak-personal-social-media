import {buildLocalAxios} from '../../lib/http/build-axios';
import {topSearchStore} from './store';
import {useEffect} from 'react';
import {useState} from '@hookstate/core';
import OutsideClickHandler from 'react-outside-click-handler';
import PreviousSearchListItem from './previous-searches-list-item';

const localAxios = buildLocalAxios();
export default function PreviousSearchesList({inputRef}) {
  const state = useState(topSearchStore);

  const listOpened = state.listOpened.get();
  const inputValue = state.inputValue.get();
  const previousSearches = state.previousSearches.get();

  useEffect(() => {
    if (previousSearches) return;

    localAxios.get('/previous_searches').then(({data: {previousSearches}}) => {
      state.merge({previousSearches});
    }).catch(() => {
      console.log('error loading previous searches');
    });
  }, [previousSearches]); // eslint-disable-line react-hooks/exhaustive-deps

  function closeList(e) {
    if (!listOpened) return;
    if (inputValue.length > 1) return;

    const {current} = inputRef;
    const target = e?.target;
    if (current === target) return;
    state.merge({listOpened: false});
  }

  return (
    <OutsideClickHandler onOutsideClick={closeList}>
      {
        listOpened && inputValue.length < 1 && previousSearches?.length > 0 && <div className="absolute top-0 mt-12 py-2 px-1 bg-yellow-300 w-64 overflow-y-hidden">
          <div className="text-sm">
            Previous searches
          </div>

          <div>
            {
              previousSearches.map((search) => {
                return (
                  <div className="my-2" key={search.id}>
                    <PreviousSearchListItem search={search} state={state}/>
                  </div>
                );
              })
            }
          </div>
        </div>
      }
    </OutsideClickHandler>
  );
}
