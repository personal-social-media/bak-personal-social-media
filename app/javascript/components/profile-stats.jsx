import {buildRemoteAxios} from '../lib/http/build-axios';
import {profileStatsStore} from './profile-stats/store';
import {useEffect} from 'react';
import {useState} from '@hookstate/core';
import FriendsCount from './profile-stats/friends-count';
import PostsCount from './profile-stats/posts-count';

export default function ProfileStats({peer_ip: peerIp}) {
  const state = useState(profileStatsStore);
  const profile = state.remoteAxios.get();

  useEffect(() => {
    const axiosClient = buildRemoteAxios(peerIp);

    axiosClient.get('/profile').then(({data: {profile}}) => {
      state.merge({
        profile,
        remoteAxios: axiosClient,
      });
    });
  }, [peerIp]); // eslint-disable-line react-hooks/exhaustive-deps

  return (
    <div className="h-10 my-4">
      {
        profile && <div className="flex justify-around">
          <PostsCount/>
          <FriendsCount/>
        </div>
      }
    </div>
  );
}
