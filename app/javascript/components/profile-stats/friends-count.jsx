import {intToString} from '../../lib/format/numbers';
import {profileStatsStore} from './store';
import {useState} from '@hookstate/core';

export default function FriendsCount() {
  const state = useState(profileStatsStore);

  return (
    <div className="flex">
      <div className="font-semibold">
        {intToString(state.profile.account.friendsCount.get())}
      </div>
      <div className="ml-2">
        friends
      </div>
    </div>
  );
}
