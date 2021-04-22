import {feedBackError} from '../../../events/feedback';
import {fetchPosts} from '../actions/fetch-posts';
import {uniqBy} from 'lodash';
import {useInfiniteLoader} from 'masonic';
import {useRef} from 'react';

export function useProfilePostInfiniteLoad({state, postsCount, remoteAxios, peerInfo}) {
  const loadedPostsIndexesRef = useRef([]);

  const fetchMorePosts = async (startIndex, endIndex) => {
    const newIndex = {endIndex, startIndex};
    const loadedPostsIndexes = loadedPostsIndexesRef.current;

    const existing = loadedPostsIndexes.find((el) => {
      return el.startIndex === newIndex.startIndex && el.endIndex === newIndex.endIndex;
    });
    if (existing || (startIndex === endIndex)) return;
    loadedPostsIndexes.push(newIndex);

    try {
      const {data: {posts}} = await fetchPosts(remoteAxios, startIndex, endIndex);
      posts.forEach((p) => p.peerInfo = peerInfo);

      state.merge((s) => {
        return {
          posts: uniqBy([...s.posts, ...posts], 'uid'),
        };
      });
    } catch (e) {
      feedBackError('unable to fetch posts');
    }
  };
  const maybeLoadMore = useInfiniteLoader(fetchMorePosts, {
    isItemLoaded: (index, items) => !!items[index],
    totalItems: postsCount + 1,
  });

  return {maybeLoadMore};
}
