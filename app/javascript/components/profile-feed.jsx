import {buildRemoteAxios} from '../lib/http/build-axios';
import {createState, useState} from '@hookstate/core';
import {useEffect} from 'react';
import Bugsnag from './utils/bugsnag';
import PostsLoader from './profile-feed/posts-loader';
import ProfileFeedPostsList from './profile-feed/posts-list';

export const profileFeedState = createState({
  peerId: null,
  peerIp: null,
  posts: [],
  remoteAxios: null,
});

export default function ProfileFeed({peer}) {
  const state = useState(profileFeedState);
  const {id: peerId, ip: peerIp} = peer;
  const remoteAxios = buildRemoteAxios(peerIp);

  useEffect(() => {
    state.merge({
      peerId,
      peerIp,
    });
  }, [peerId, peerIp, state]);

  return (
    <Bugsnag>
      <PostsLoader remoteAxios={remoteAxios} peerInfo={peer}>
        <ProfileFeedPostsList remoteAxios={remoteAxios}/>
      </PostsLoader>
    </Bugsnag>
  );
}
