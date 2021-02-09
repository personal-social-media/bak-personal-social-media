import {createState, useState} from '@hookstate/core';
import {feedBackError} from '../../../events/feedback';
import {profileActionsStore} from '../store';
import {updateFriendshipRequest} from '../../../lib/peer-to-peer-actions/friendship/update-request';

const initialButtonState = {
  accept: {
    disabled: false,
    text: 'Accept',
  },
  decline: {
    disabled: false,
    text: 'Decline',
  },
};

const _buttonState = createState(initialButtonState);

export default function AcceptFriendShip() {
  const state = useState(profileActionsStore);
  const buttonState = useState(_buttonState);

  const peerId = state.peerInfo.id.get();
  async function answer(option) {
    buttonState.merge({
      accept: {disabled: true},
      decline: {disabled: true},
    });
    try {
      const response = await updateFriendshipRequest(peerId, option);
      const {friendShipStatus} = response.data.peerInfo;
      state.merge({
        peerInfo: {
          friendShipStatus,
        },
      });
    } catch {
      buttonState.merge(initialButtonState);
      feedBackError('Unable respond to request');
    }
  }

  return (
    <div>
      <button className="pure-button pure-button-primary" onClick={() => answer('accepted')} disabled={buttonState.accept.disabled.get()}>
        {buttonState.accept.text.get()}
      </button>

      <button className="ml-3 pure-button" onClick={() => answer('declined')} disabled={buttonState.decline.disabled.get()}>
        {buttonState.decline.text.get()}
      </button>
    </div>
  );
}
