import {search, topSearchStore} from './store';
import {useState} from '@hookstate/core';
import FadeIn from 'react-fade-in';
import OutsideClickHandler from 'react-outside-click-handler';
import SearchListItem from './list-item';
import useInputIntervalHook from '../../lib/hooks/input-interval-hook';

export default function SearchList() {
  const state = useState(topSearchStore);
  const listOpened = state.listOpened.get();

  useInputIntervalHook(state.inputValue, 500, '', (val) => {
    search(val, state);
  });

  function closeList() {
    if (!listOpened) {
      return;
    }

    state.merge({listOpened: false});
  }

  const localSearches = state.localSearches.get();
  const registrySearches = state.registrySearches.get();

  return (
    <OutsideClickHandler onOutsideClick={closeList}>
      {
        listOpened &&
        <div className="absolute top-0 mt-12 py-2 px-1 bg-yellow-300 w-64 overflow-y-hidden" style={{minHeight: '30rem'}}>
          <div className="text-gray-700 text-sm">
            Known peers:
          </div>

          {
            <FadeIn>
              {localSearches.map((identity) => {
                return (
                  <div key={identity.id} className="my-2">
                    <SearchListItem identity={identity} displayName={identity.name} link={`/u/${identity.id}`} closeList={closeList}/>
                  </div>
                );
              })}
            </FadeIn>
          }


          <div className="text-gray-700 text-sm">
            Registry peers:
          </div>


          <FadeIn>
            {registrySearches.map((identity) => {
              return (
                <div key={identity.publicKey} className="my-2">
                  <SearchListItem identity={identity} displayName={`@${identity.username}`} closeList={closeList}/>
                </div>
              );
            })}
          </FadeIn>
        </div>
      }
    </OutsideClickHandler>
  );
}
