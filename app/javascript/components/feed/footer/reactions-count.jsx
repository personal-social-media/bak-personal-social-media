import {makeFriendlyNumber} from '../../../lib/format/numbers';
import {sum} from 'lodash';
import ReactionsCountIcons from './reactions-count/reactions-icons';

export default function ReactionsCount({post}) {
  const wowCount = post.wowCount.get();
  const likeCount = post.likeCount.get();
  const loveCount = post.loveCount.get();
  const total = sum([wowCount, likeCount, loveCount]);
  const cacheReaction = post.cacheReaction.get();

  if (!cacheReaction && total < 1) return null;

  return (
    <div className="flex items-center">
      <ReactionsCountIcons
        likeCount={{count: likeCount, type: 'like'}}
        loveCount={{count: loveCount, type: 'love'}}
        wowCount={{count: wowCount, type: 'wow'}}
      />
      <span className="ml-1">{makeFriendlyNumber(total)}</span>
    </div>
  );
}
