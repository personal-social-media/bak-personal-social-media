import LikeReaction from '../../reactions/like-reaction';
import LoveReaction from '../../reactions/love-reaction';
import ReactionButton from './reaction-button';
import WowReaction from '../../reactions/wow-reaction';

export default function CurrentReaction({cacheReaction, saveReaction, imageOptions, containerOptions}) {
  const reactionType = cacheReaction?.reactionType;

  if (!reactionType || reactionType === 'like') {
    return (
      <ReactionButton reactionType="like" saveReaction={saveReaction}>
        <LikeReaction cacheReaction={cacheReaction} imageOptions={imageOptions} containerOptions={containerOptions}/>
      </ReactionButton>
    );
  }

  if (reactionType === 'love') {
    return (
      <ReactionButton reactionType="love" saveReaction={saveReaction}>
        <LoveReaction cacheReaction={cacheReaction} imageOptions={imageOptions} containerOptions={containerOptions}/>
      </ReactionButton>
    );
  }

  if (reactionType === 'wow') {
    return (
      <ReactionButton reactionType="wow" saveReaction={saveReaction}>
        <WowReaction cacheReaction={cacheReaction} imageOptions={imageOptions} containerOptions={containerOptions}/>
      </ReactionButton>
    );
  }
}
