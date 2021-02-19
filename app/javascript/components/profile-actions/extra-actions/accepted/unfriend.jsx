import {createState, useState} from '@hookstate/core';
import {feedBackError} from '../../../../events/feedback';
import {profileActionsStore} from '../../store';
import {unfriendRequest} from '../../../../lib/peer-to-peer-actions/friendship/unfriend-request';

const defaultState = {
  _destroy: {
    text: 'Unfriend',
  },
  block: {
    text: 'Block',
  },
  disabled: false,
};

const _state = createState({...defaultState});

export default function Unfriend() {
  const state = useState(_state);
  const profileState = useState(profileActionsStore);
  const peerId = profileState.peerInfo.id.get();

  async function removeFriendship(e, option, key) {
    e.preventDefault();
    state.merge((s) => {
      return {
        disabled: true,
        [key]: {
          text: s[key].text + 'ing...',
        },
      };
    });
    try {
      await unfriendRequest(peerId, option);
    } catch {
      state.merge({
        disabled: false,
      });
      feedBackError('Unable to unfriend');
    }

    window.Turbolinks.visit('/');
  }

  return (
    <div>
      <div>
        <div>
          <button onClick={(e) => removeFriendship(e, 'destroy', '_destroy')}
            className="pure-button pure-button-primary w-full" disabled={state.disabled.get()}>
            {state._destroy.text.get()}
          </button>
          <div className="text-xs text-right italic pt-2">
            Doing this will remove all data from the peers server and vice versa for his
          </div>
        </div>

        <div className="mt-4">
          <button onClick={(e) => removeFriendship(e, 'block', 'block')}
            className="pure-button pure-button-primary w-full" disabled={state.disabled.get()}>
            {state.block.text.get()}
          </button>
          <div className="text-xs text-right italic pt-2">
            Block a user will prevent him from adding you / seeing your profile and vice versa for you
          </div>
        </div>
      </div>
    </div>
  );
}
