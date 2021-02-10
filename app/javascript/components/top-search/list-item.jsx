import {createNewPreviousSearch} from '../../lib/peer-to-peer-actions/search/create-new-previous-search';
import {getImageForDevice, userPlaceholder} from '../../lib/device/device-type';
import {handleNewPeer} from '../../lib/peer-to-peer-actions/search/new-peer';
import {useRef, useState} from 'react';

export default function SearchListItem({link = '#', identity, displayName}) {
  const [state, setState] = useState({realDisplayName: displayName, realLink: link});
  const avatar = getImageForDevice(identity.avatars, userPlaceholder);
  const anchor = useRef();

  const {realLink, realDisplayName} = state;

  async function handleOpen(e) {
    const {href} = anchor.current;
    if (href.indexOf('#') === -1) {
      return await createNewPreviousSearch(identity);
    }
    await handleNewPeer(e, identity, state, setState);
  }

  return (
    <a href={realLink} className="no-underline" onClick={handleOpen} ref={anchor}>
      <div className="flex items-center">
        <img src={avatar} alt={identity.username} className="h-10 w-10 rounded-full object-cover"/>

        <div className="ml-1 text-gray-700 text-lg">
          {realDisplayName}
        </div>
      </div>
    </a>
  );
}
