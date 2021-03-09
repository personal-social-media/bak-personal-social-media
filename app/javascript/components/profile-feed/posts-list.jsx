import {List} from 'masonic';
import {profileFeedState} from '../profile-feed';
import {useCallback} from 'react';
import {useState} from '@hookstate/core';
import FeedPost from '../feed/post';

export default function ProfileFeedPostsList({remoteAxios}) {
  const state = useState(profileFeedState);
  const posts = state.posts.get();

  const FeedPostWrapper = useCallback((props) => {
    return (
      <FeedPost {...props} state={state}/>
    );
  }, [state]);

  return (
    <List items={posts} rowGutter={32} render={FeedPostWrapper} overscanBy={4}/>
  );
}
