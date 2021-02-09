import {buildLocalAxios} from '../../lib/http/build-axios';
import {createState} from '@hookstate/core';

export const profileActionsStore = createState({
  localAxios: buildLocalAxios(),
  peerInfo: null,
});
