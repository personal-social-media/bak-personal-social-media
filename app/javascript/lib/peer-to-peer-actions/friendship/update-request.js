import {buildLocalAxios} from '../../http/build-axios';

const axios = buildLocalAxios();
export function updateFriendshipRequest(peerId, option) {
  return axios.patch(`/client/friendships/${peerId}`, {option});
}
