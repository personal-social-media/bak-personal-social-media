import {localAxios} from '../../http/build-axios';

export function updateReaction(cacheReaction, reactionType) {
  return localAxios.put(`/client/cache_reactions/${cacheReaction.id}`, {reactionType});
}
