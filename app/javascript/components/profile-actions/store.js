import {createState} from '@hookstate/core';
import {localAxios} from '../../lib/http/build-axios';

export const profileActionsStore = createState({
  localAxios: localAxios,
  peerInfo: null,
});
