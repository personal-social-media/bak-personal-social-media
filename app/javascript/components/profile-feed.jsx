import {createState, useState} from "@hookstate/core";
import {useEffect} from "react";

export const profileFeedState = createState({
  peerIp: null
});

export default function ProfileFeed({peer_id: peerId}){
  const state = useState(profileFeedState);
  useEffect(() => {
    state.merge({peerId});
  }, [peerId]);

  return(
    <div>
      {state.peerIp.get()}
    </div>
  )
}