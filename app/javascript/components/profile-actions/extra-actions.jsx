import {profileActionsStore} from './store';
import {useState} from '@hookstate/core';
import ExtraActionsAccepted from './extra-actions/accepted';
import ExtraActionsSelf from './extra-actions/self';

export default function ProfileExtraActions() {
  const state = useState(profileActionsStore);
  const friendShipStatus = state.peerInfo.friendShipStatus.get();

  return (
    <div>
      {friendShipStatus === 'self' && <ExtraActionsSelf/>}
      {friendShipStatus === 'accepted' && <ExtraActionsAccepted/>}
    </div>
  );
}
