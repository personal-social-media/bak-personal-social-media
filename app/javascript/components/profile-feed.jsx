import {buildRemoteAxios} from '../lib/http/build-axios';
import {createState, useState} from '@hookstate/core';
import {useEffect} from 'react';
import Bugsnag from './utils/bugsnag';
import PostsLoader from './profile-feed/posts-loader';

export const profileFeedState = createState({
  peerId: null,
  peerIp: null,
  posts: null,
  remoteAxios: null,
});

export default function ProfileFeed({peer}) {
  const state = useState(profileFeedState);
  useEffect(() => {
    const {id: peerId, ip: peerIp} = peer;

    state.merge({
      peerId,
      peerIp,
      remoteAxios: buildRemoteAxios(peerIp),
    });
  }, [peer]); // eslint-disable-line react-hooks/exhaustive-deps

  const remoteAxios = state.remoteAxios.get();
  if (!remoteAxios) {
    return null;
  }

  return (
    <Bugsnag>
      <div>
        <PostsLoader/>
      </div>
    </Bugsnag>
  );
}
