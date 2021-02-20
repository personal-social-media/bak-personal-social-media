import {localAxios} from '../../http/build-axios';

export function createFriendshipRequest(peerId) {
  return localAxios.post('/client/friendships', {id: peerId});
}
