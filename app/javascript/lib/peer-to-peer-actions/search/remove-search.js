import {localAxios} from '../../http/build-axios';

export function removeFromSearch(search) {
  return localAxios.delete(`/previous_searches/${search.id}`);
}
