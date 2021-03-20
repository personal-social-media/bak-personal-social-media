import {localAxios} from '../../http/build-axios';

export function createReaction(peerId, payloadSubjectId, payloadSubjectType, reactionType) {
  return localAxios.post('/client/cache_reactions', {payloadSubjectId, payloadSubjectType, peerInfoId: peerId, reactionType});
}
