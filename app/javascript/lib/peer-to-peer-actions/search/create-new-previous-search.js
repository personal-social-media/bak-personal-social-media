import {localAxios} from '../../http/build-axios';

export function createNewPreviousSearch(peerInfo) {
  return localAxios.post('/previous_searches', {peerInfo: {id: peerInfo.id}});
}
