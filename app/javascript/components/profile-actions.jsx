import {profileActionsStore} from './profile-actions/store';
import {useEffect} from 'react';
import {useState} from '@hookstate/core';
import Bugsnag from './utils/bugsnag';
import ProfileExtraActions from './profile-actions/extra-actions';
import ProfileFriendship from './profile-actions/friendship';

export default function ProfileActions({peerInfo}) {
  const state = useState(profileActionsStore);
  const profile = state.peerInfo.get();

  useEffect(() => {
    state.merge({peerInfo});
  }, [peerInfo]); // eslint-disable-line react-hooks/exhaustive-deps

  return (
    <Bugsnag>
      <div>
        {
          profile && <div className="flex items-center">
            <ProfileFriendship/>
            <div className="ml-2">
              <ProfileExtraActions/>
            </div>
          </div>
        }
      </div>
    </Bugsnag>
  );
}
