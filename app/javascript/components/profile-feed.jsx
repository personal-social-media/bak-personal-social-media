import {buildRemoteAxios} from '../lib/http/build-axios';
import {createState, useState} from '@hookstate/core';
import {useEffect} from 'react';

export const profileFeedState = createState({
  peerId: null,
  peerIp: null,
  remoteAxios: null,
});

export default function ProfileFeed({peer_id: peerId, peer_ip: peerIp}) {
  const state = useState(profileFeedState);
  useEffect(() => {
    state.merge({
      peerId,
      peerIp,
      remoteAxios: buildRemoteAxios(peerIp),
    });
  }, [peerId]); // eslint-disable-line react-hooks/exhaustive-deps

  return (
    <div>
      {state.peerIp.get()}
    </div>
  );
}
