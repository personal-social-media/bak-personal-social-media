import {createNewPeerInfo} from './store';
import {feedBackError} from '../../events/feedback';
import {getImageForDevice, userPlaceholder} from '../../lib/device/device-type';
import {useRef, useState} from 'react';

export default function SearchListItem({link = '#', identity, displayName, closeList}) {
  const [state, setState] = useState({realDisplayName: displayName, realLink: link});
  const avatar = getImageForDevice(identity.avatars, userPlaceholder);
  const anchor = useRef();

  const {realLink, realDisplayName} = state;

  async function handleOpen(e) {
    let peerInfo;
    const {href} = anchor.current;
    if (href.indexOf('#') === -1) return closeList();

    e.stopPropagation();
    e.preventDefault();
    setState({...state, realDisplayName: 'Fetching server information'});

    try {
      peerInfo = await createNewPeerInfo(identity);
    } catch (e) {
      return feedBackError(`Unable to fetch server information for ${identity.username}`);
    }
    closeList();
    const url = `/u/${peerInfo.id}`;
    Turbolinks.visit(url);
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
