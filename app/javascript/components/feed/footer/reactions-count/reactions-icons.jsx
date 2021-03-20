import {sortBy} from 'lodash';
import LikeReaction from '../../../reactions/like-reaction';
import LoveReaction from '../../../reactions/love-reaction';
import WowReaction from '../../../reactions/wow-reaction';

const imageOptionsReaction = {className: 'h-6 w-6'};
export default function ReactionsCountIcons({wowCount, likeCount, loveCount}) {
  let result = [wowCount, likeCount, loveCount].filter((e) => e.count > 0);
  result = sortBy(result, 'count').reverse().slice(0, 3);

  result = result.map(({type}) => {
    if (type === 'like') {
      return (
        <LikeReaction imageOptions={imageOptionsReaction} key={type}/>
      );
    }

    if (type === 'love') {
      return (
        <LoveReaction imageOptions={imageOptionsReaction} key={type}/>
      );
    }

    if (type === 'wow') {
      return (
        <WowReaction imageOptions={imageOptionsReaction} key={type}/>
      );
    }
  });

  return result;
}
