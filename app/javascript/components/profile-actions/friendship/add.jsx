import {createFriendshipRequest} from '../../../lib/peer-to-peer-actions/friendship/create-request';
import {createState, useState} from '@hookstate/core';
import {feedBackError} from '../../../events/feedback';
import {profileActionsStore} from '../store';

const initialButtonState = {
  disabled: false,
  text: 'Add',
};

const _buttonState = createState(initialButtonState);

export default function AddFriendship() {
  const state = useState(profileActionsStore);
  const buttonState = useState(_buttonState);

  const peerId = state.peerInfo.id.get();
  async function add() {
    buttonState.merge({
      disabled: true,
      text: 'Adding...',
    });
    try {
      const response = await createFriendshipRequest(peerId);
      const {friendShipStatus} = response.data.peerInfo;
      state.merge({
        peerInfo: {
          friendShipStatus,
        },
      });
    } catch {
      buttonState.merge(initialButtonState);
      feedBackError('Unable to add');
    }
  }

  return (
    <div>
      <button className="pure-button pure-button-primary" onClick={add} disabled={buttonState.disabled.get()}>
        {buttonState.text.get()}
      </button>
    </div>
  );
}
