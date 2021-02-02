import {createState, useState} from "@hookstate/core";
import {useEffect} from "react";

export const profileFeedState = createState({
  peerIp: null
});

export default function ProfileFeed({peer_ip: peerIp}){
  const state = useState(profileFeedState);
  useEffect(() => {
    state.merge({peerIp});
  }, [peerIp]);

  return(
    <div>
      {state.peerIp.get()}
    </div>
  )
}