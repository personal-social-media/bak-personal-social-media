import {localAxios} from '../../http/build-axios';

export function destroyReaction(cacheReaction) {
  return localAxios.delete(`/client/cache_reactions/${cacheReaction.id}`);
}
