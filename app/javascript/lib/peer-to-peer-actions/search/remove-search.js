import {buildLocalAxios} from '../../http/build-axios';

const axios = buildLocalAxios();
export function removeFromSearch(search) {
  return axios.delete(`/previous_searches/${search.id}`);
}
