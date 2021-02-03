import {fetchPosts} from './actions/fetch-posts';
import {profileFeedState} from '../profile-feed';
import {useEffect} from 'react';
import {useState} from '@hookstate/core';
import FeedPost from '../feed/post';

export default function PostsLoader() {
  const state = useState(profileFeedState);
  const remoteAxios = state.remoteAxios.get();
  const posts = state.posts.get();

  useEffect(() => {
    if (posts !== null) {
      return;
    }

    fetchPosts(remoteAxios, state);
  }, [posts, remoteAxios]); // eslint-disable-line react-hooks/exhaustive-deps

  if (!posts) {
    return null;
  }

  return (<div>
    {
      posts.map((post) => {
        return <FeedPost key={post.uid} post={post}/>;
      })
    }
  </div>);
}
