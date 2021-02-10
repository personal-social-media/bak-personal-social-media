import {buildLocalAxios} from '../../http/build-axios';

const axios = buildLocalAxios();
export function unfriendRequest(peerId, option) {
  return axios.delete(`/client/friendships/${peerId}?option=${option}`);
}
