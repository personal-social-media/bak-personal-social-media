import {List} from 'masonic';
import {profileFeedState} from '../profile-feed';
import {useCallback} from 'react';
import {useProfilePostInfiniteLoad} from './hooks/use-profile-post-infinite-load';
import {useState} from '@hookstate/core';
import FeedPost from '../feed/post';

export default function ProfileFeedPostsList({remoteAxios, peerInfo}) {
  const state = useState(profileFeedState);
  const posts = state.posts;
  const postsCount = state.postsCount.get();

  const FeedPostWrapper = useCallback((props) => {
    return (
      <FeedPost {...props} state={state}/>
    );
  }, []); // eslint-disable-line react-hooks/exhaustive-deps

  const {maybeLoadMore} = useProfilePostInfiniteLoad({peerInfo, postsCount, remoteAxios, state});

  return (
    <List items={posts} rowGutter={32}
      className="no-outline"
      render={FeedPostWrapper}
      onRender={maybeLoadMore}
    />
  );
}
