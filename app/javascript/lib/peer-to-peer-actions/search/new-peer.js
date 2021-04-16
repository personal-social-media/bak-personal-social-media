import {createNewPeerInfo} from '../../../components/top-search/store';
import {createNewPreviousSearch} from './create-new-previous-search';
import {feedBackError} from '../../../events/feedback';

export async function handleNewPeer(e, identity, state, setState) {
  let peerInfo;
  e.stopPropagation();
  e.preventDefault();
  setState({...state, realDisplayName: 'Fetching server information'});

  try {
    peerInfo = await createNewPeerInfo(identity);
  } catch (e) {
    return feedBackError(`Unable to fetch server information for ${identity.username.get()}`);
  }

  await createNewPreviousSearch(peerInfo);
  const url = `/u/${peerInfo.id}`;
  window.Turbolinks.visit(url);
}
