import {localAxios} from '../../http/build-axios';

export function updateFriendshipRequest(peerId, option) {
  return localAxios.patch(`/client/friendships/${peerId}`, {option});
}
