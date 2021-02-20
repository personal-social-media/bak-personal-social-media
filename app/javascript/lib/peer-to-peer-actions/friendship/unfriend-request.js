import {localAxios} from '../../http/build-axios';

export function unfriendRequest(peerId, option) {
  return localAxios.delete(`/client/friendships/${peerId}?option=${option}`);
}
