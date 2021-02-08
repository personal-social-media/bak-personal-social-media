import {buildSimpleAxios} from '../../lib/http/build-axios';
import {createState} from '@hookstate/core';
const registryAxios = buildSimpleAxios('https://registry.personalsocialmedia.net');

export const topSearchStore = createState({
  inputValue: '',
  searches: [],
  searching: false,
});

export function search(value, state) {
  let remoteSearchRunning = true;
  const localSearchRunning = true;
  state.merge({searching: true});
  const promises = [];

  const registryPromise = registryAxios.get(`/identities?q=${value}`).then(({data: {identities}}) => {
    if (localSearchRunning) {
      state.merge({searches: identities});
    } else {
      state.merge({searches: identities});
    }
  }).finally(() => {
    remoteSearchRunning = false;
  });
  promises.push(registryPromise);

  Promise.all(promises).then(() => {
    state.merge({searching: false});
  });
}
