import {localAxios} from '../http/build-axios';
import EventQueue from './queue';

const queue = new EventQueue(100, 200, async (items) => {
  const search = items.map(({item, type}) => {
    return {
      payloadSubjectId: item.uid,
      payloadSubjectType: type,
    };
  });

  const {data: {cacheReactions}} = await localAxios.post('/client/cache_reactions/search', {search});
  console.log(search, cacheReactions);
});

export function queueFeedFetchCacheReactions({state, item, type}) {
  queue.push({item, state, type});
  queue.runNow();
}
