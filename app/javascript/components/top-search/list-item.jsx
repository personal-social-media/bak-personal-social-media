import {createNewPreviousSearch} from '../../lib/peer-to-peer-actions/search/create-new-previous-search';
import {handleNewPeer} from '../../lib/peer-to-peer-actions/search/new-peer';
import {useRef, useState} from 'react';
import UserAvatar from '../user/avatar';

export default function SearchListItem({link = '#', identity, displayName, storeState}) {
  const [state, setState] = useState({realDisplayName: displayName, realLink: link});
  const username = identity.username.get();
  const avatars = identity.avatars.get();
  const anchor = useRef();

  const {realLink, realDisplayName} = state;

  async function handleOpen(e) {
    const {href} = anchor.current;
    if (href.indexOf('#') === -1) {
      const response = await createNewPreviousSearch(identity);
      const {previousSearch} = response.data;

      return storeState.merge((s) => {
        const previousSearches = s.previousSearches.filter((prev) => {
          prev.id !== previousSearch.id;
        });
        previousSearches.unshift(previousSearch);
        return {
          previousSearches,
        };
      });
    }
    await handleNewPeer(e, identity, state, setState);
  }

  return (
    <a href={realLink} className="no-underline" onClick={handleOpen} ref={anchor}>
      <div className="flex items-center">
        <UserAvatar avatars={avatars} username={username} imageOptions={{className: 'h-10 w-10 rounded-full object-cover object-center'}}/>

        <div className="ml-1 text-gray-700 text-lg">
          {realDisplayName}
        </div>
      </div>
    </a>
  );
}
