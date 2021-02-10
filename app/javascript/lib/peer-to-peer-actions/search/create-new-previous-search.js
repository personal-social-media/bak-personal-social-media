import {buildLocalAxios} from '../../http/build-axios';

const axios = buildLocalAxios();
export function createNewPreviousSearch(peerInfo) {
  return axios.post('/previous_searches', {peerInfo: {id: peerInfo.id}});
}
