import {feedBackError} from '../../events/feedback';
import {fetchPosts} from './actions/fetch-posts';
import {profileFeedState} from '../profile-feed';
import {useEffect} from 'react';
import {useState} from '@hookstate/core';

export default function PostsLoader({remoteAxios, peerInfo, children}) {
  const state = useState(profileFeedState);
  useEffect(() => {
    fetchPosts(remoteAxios).then(({data: {posts}}) => {
      state.merge({
        posts: posts.map((post) => {
          return {
            ...post,
            peerInfo,
          };
        }),
      });
    }).catch(() => {
      feedBackError('Unable to load posts');
    });

    return () => {
      state.merge({
        posts: [],
      });
    };
  }, [state, peerInfo, remoteAxios]);

  return children;
  // const remoteAxios = state.remoteAxios.get();
  // const posts = state.posts.get();
  //
  // useEffect(() => {
  //   if (posts !== null) {
  //     return;
  //   }
  //
  //   fetchPosts(remoteAxios, state);
  // }, [posts, remoteAxios]); // eslint-disable-line react-hooks/exhaustive-deps
  //
  // if (!posts) {
  //   return null;
  // }
  //
  // return (<div>
  //   {
  //     posts.map((post) => {
  //       return <FeedPost key={post.uid} post={post}/>;
  //     })
  //   }
  // </div>);
}
