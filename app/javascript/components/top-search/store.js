import {buildSimpleAxios, localAxios} from '../../lib/http/build-axios';
import {createState} from '@hookstate/core';
import {peerInfoVerification} from '../../lib/verifications/peer-info-verification';
const registryAxios = buildSimpleAxios('https://registry.personalsocialmedia.net');

export const topSearchStore = createState({
  inputValue: '',
  listOpened: false,
  localSearches: [],
  localSearching: false,
  previousSearches: null,
  registrySearches: [],
  registrySearching: false,
});

export function search(value, state) {
  state.merge({localSearches: [], localSearching: true, registrySearches: [], registrySearching: true});

  registryAxios.get(`/identities?q=${value}`).then(({data: {identities}}) => {
    const verifiedPeerInfos = identities.filter((i) => peerInfoVerification(i, 'serverIp'));

    state.merge({registrySearches: verifiedPeerInfos, registrySearching: false});
  }).catch(() => {
    state.merge({localSearching: false});
  });

  localAxios.get(`/peer_infos?name_like=${value}`).then(({data: {peerInfos}}) => {
    state.merge({localSearches: peerInfos, localSearching: false});
  }).catch(() => {
    state.merge({localSearching: false});
  });
}

export async function createNewPeerInfo(peerInfo) {
  const data = {
    peerInfo: {
      avatars: peerInfo.avatars.get(),
      name: peerInfo.name.get(),
      publicKey: peerInfo.publicKey.get(),
      username: peerInfo.username.get(),
    },
  };
  data.peerInfo.ip = peerInfo.serverIp.get();

  const response = await localAxios.post('/peer_infos', data);
  return response.data.peerInfo;
}
