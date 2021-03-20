import {localAxios} from '../http/build-axios';
import EventQueue from './queue';

const queue = new EventQueue(100, 200, async (items) => {
  const filteredItems = items.filter((item) => {
    return !item.item.cacheReaction.get();
  });

  const search = filteredItems.map(({item, type}) => {
    return {
      payloadSubjectId: item.uid.get(),
      payloadSubjectType: type,
    };
  });

  const {data: {cacheReactions}} = await localAxios.post('/client/cache_reactions/search', {search});
  console.log(cacheReactions);
  cacheReactions.forEach((cacheReaction) => {
    const {item} = items.find((i) => {
      const uid = i.item.uid.get();
      return uid === cacheReaction.payloadSubjectId;
    });
    if (!item) {
      return;
    }
    item.merge({cacheReaction});
  });
});

export function queueFeedFetchCacheReactions({state, item, type}) {
  queue.push({item, state, type});
  queue.runNow();
}
