import {createReaction} from './create-reaction';
import {destroyReaction} from './destroy-reaction';
import {feedBackError} from '../../../events/feedback';
import {updateReaction} from './update-reaction';

export async function saveReaction(cacheReactionRecord, peerId, payloadSubjectId, payloadSubjectType, reactionType, item) {
  if (!cacheReactionRecord) {
    try {
      const {cacheReaction} = await createReaction(peerId, payloadSubjectId, payloadSubjectType, reactionType);
      return item.merge({cacheReaction});
    } catch {
      return feedBackError('unable to react');
    }
  }
  if (cacheReactionRecord.reactionType !== reactionType) {
    try {
      const {cacheReaction} = await updateReaction(cacheReactionRecord, reactionType);
      return item.merge({cacheReaction});
    } catch (e) {
      return feedBackError('unable to react');
    }
  }

  try {
    await destroyReaction(cacheReactionRecord);

    return item.merge({cacheReaction: null});
  } catch {
    return feedBackError('unable to remove reaction');
  }
}
