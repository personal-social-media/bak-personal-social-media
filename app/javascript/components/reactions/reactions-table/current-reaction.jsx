import LikeReaction from '../like-reaction';
import LoveReaction from '../love-reaction';
import ReactionButton from './reaction-button';
import WowReaction from '../wow-reaction';

export default function CurrentReaction({cacheReaction, saveReaction, imageOptions, containerOptions, loading}) {
  const reactionType = cacheReaction?.reactionType;

  if (!reactionType || reactionType === 'like') {
    return (
      <ReactionButton reactionType="like" saveReaction={saveReaction} loading={loading}>
        <LikeReaction cacheReaction={cacheReaction} imageOptions={imageOptions} containerOptions={containerOptions}/>
      </ReactionButton>
    );
  }

  if (reactionType === 'love') {
    return (
      <ReactionButton reactionType="love" saveReaction={saveReaction} loading={loading}>
        <LoveReaction cacheReaction={cacheReaction} imageOptions={imageOptions} containerOptions={containerOptions}/>
      </ReactionButton>
    );
  }

  if (reactionType === 'wow') {
    return (
      <ReactionButton reactionType="wow" saveReaction={saveReaction} loading={loading}>
        <WowReaction cacheReaction={cacheReaction} imageOptions={imageOptions} containerOptions={containerOptions}/>
      </ReactionButton>
    );
  }
}
