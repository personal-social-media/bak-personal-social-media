import {profileActionsStore} from './store';
import {useState} from '@hookstate/core';
import AcceptFriendShip from './friendship/accept';
import AddFriendship from './friendship/add';
import SelfFriendShip from './friendship/self';
import Static from './friendship/static';

export default function ProfileFriendship() {
  const state = useState(profileActionsStore);
  const friendShipStatus = state.peerInfo.friendShipStatus.get();
  const staticValue = ['accepted', 'requested', 'declined'].indexOf(friendShipStatus) !== -1;

  return (
    <div>
      {friendShipStatus === 'self' && <SelfFriendShip/>}
      {friendShipStatus === 'stranger' && <AddFriendship/>}
      {friendShipStatus === 'pending_accept' && <AcceptFriendShip/>}
      {staticValue && <Static value={friendShipStatus}/>}
    </div>
  );
}
