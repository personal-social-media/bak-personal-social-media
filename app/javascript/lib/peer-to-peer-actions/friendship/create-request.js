import {buildLocalAxios} from '../../http/build-axios';

const axios = buildLocalAxios();
export function createFriendshipRequest(peerId) {
  return axios.post('/client/friendships', {id: peerId});
}
