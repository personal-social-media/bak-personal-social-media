import {createReaction} from './create-reaction';
import {destroyReaction} from './destroy-reaction';
import {feedBackError} from '../../../events/feedback';
import {updateReaction} from './update-reaction';

export async function saveReaction(cacheReactionRecord, peerId, payloadSubjectId, payloadSubjectType, reactionType, item) {
  if (!cacheReactionRecord) {
    try {
      const {cacheReaction} = await createReaction(peerId, payloadSubjectId, payloadSubjectType, reactionType);
      const incrementedField = getCounterName(reactionType);
      return item.merge((item) => {
        return {
          cacheReaction,
          [incrementedField]: item[incrementedField] + 1,
        };
      });
    } catch {
      return feedBackError('unable to react');
    }
  }
  if (cacheReactionRecord.reactionType !== reactionType) {
    const incrementedField = getCounterName(reactionType);
    const decrementField = getCounterName(cacheReactionRecord.reactionType);
    try {
      const {cacheReaction} = await updateReaction(cacheReactionRecord, reactionType);
      return item.merge((item) => {
        return {
          cacheReaction,
          [decrementField]: item[decrementField] - 1,
          [incrementedField]: item[incrementedField] + 1,
        };
      });
    } catch (e) {
      return feedBackError('unable to react');
    }
  }

  try {
    const decrementField = getCounterName(cacheReactionRecord.reactionType);
    await destroyReaction(cacheReactionRecord);

    return item.merge((item) => {
      return {
        cacheReaction: null,
        [decrementField]: item[decrementField] - 1,
      };
    });
  } catch {
    return feedBackError('unable to remove reaction');
  }
}

function getCounterName(reactionType) {
  return `${reactionType}Count`;
}
