import {search, topSearchStore} from './store';
import {useState} from '@hookstate/core';
import FadeIn from 'react-fade-in';
import OutsideClickHandler from 'react-outside-click-handler';
import SearchListItem from './list-item';
import useInputIntervalHook from '../../lib/hooks/input-interval-hook';

export default function SearchList({inputRef}) {
  const state = useState(topSearchStore);
  const listOpened = state.listOpened.get();
  const inputValue = state.inputValue.get();

  useInputIntervalHook(state.inputValue, 500, '', (val) => {
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

  const localSearches = state.localSearches.get();
  const registrySearches = state.registrySearches.get();
  return (
    <OutsideClickHandler onOutsideClick={closeList}>
      {
        listOpened && inputValue.length > 0 &&
        <div className="absolute top-0 mt-20 py-2 px-1 bg-white w-64 overflow-y-hidden">
          <div style={{minHeight: '5rem'}}>
            <div className="text-gray-700 text-sm">
              Known peers:
            </div>

            {
              <FadeIn className="local-searches-list">
                {localSearches.map((identity) => {
                  return (
                    <div key={identity.id} className="my-2">
                      <SearchListItem identity={identity} displayName={identity.name} link={`/u/${identity.id}`} storeState={state}/>
                    </div>
                  );
                })}
              </FadeIn>
            }
          </div>

          <div style={{minHeight: '5rem'}}>
            <div className="text-gray-700 text-sm">
              Registry peers:
            </div>

            <FadeIn className="registry-searches-list">
              {registrySearches.map((identity) => {
                return (
                  <div key={identity.publicKey} className="my-2">
                    <SearchListItem identity={identity} displayName={`@${identity.username}`} storeState={state}/>
                  </div>
                );
              })}
            </FadeIn>
          </div>
        </div>
      }
    </OutsideClickHandler>
  );
}
