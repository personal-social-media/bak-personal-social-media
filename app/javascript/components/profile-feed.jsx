import {buildRemoteAxios} from '../lib/http/build-axios';
import {cloneDeep} from 'lodash';
import {createState, useState} from '@hookstate/core';
import {useEffect} from 'react';
import Bugsnag from './utils/bugsnag';
import PostsLoader from './profile-feed/posts-loader';
import ProfileFeedPostsList from './profile-feed/posts-list';

export const defaultProfileFeedState = {
  peerId: null,
  peerIp: null,
  posts: [],
  postsCount: null,
  remoteAxios: null,
};

export const profileFeedState = createState(cloneDeep(defaultProfileFeedState));

export default function ProfileFeed({peer}) {
  const state = useState(profileFeedState);
  const {id: peerId, ip: peerIp} = peer;
  const remoteAxios = buildRemoteAxios(peerIp);

  useEffect(() => {
    state.merge({
      peerId,
      peerIp,
    });
  }, [peerId, peerIp]); // eslint-disable-line react-hooks/exhaustive-deps

  return (
    <Bugsnag>
      <PostsLoader remoteAxios={remoteAxios} peerInfo={peer}>
        <ProfileFeedPostsList remoteAxios={remoteAxios} peerInfo={peer}/>
      </PostsLoader>
    </Bugsnag>
  );
}
