import {defaultProfileFeedState, profileFeedState} from '../profile-feed';
import {feedBackError} from '../../events/feedback';
import {fetchPosts} from './actions/fetch-posts';
import {useEffect} from 'react';
import {useState} from '@hookstate/core';

export default function PostsLoader({remoteAxios, peerInfo, children}) {
  const state = useState(profileFeedState);
  useEffect(() => {
    fetchPosts(remoteAxios).then(({data: {posts, postsCount}}) => {
      posts.forEach((p) => p.peerInfo = peerInfo);

      state.merge({
        posts: posts,
        postsCount,
      });
    }).catch(() => {
      feedBackError('Unable to load posts');
    });

    return () => {
      state.merge(defaultProfileFeedState);
    };
  }, [peerInfo, remoteAxios]); // eslint-disable-line react-hooks/exhaustive-deps

  return children;
}
