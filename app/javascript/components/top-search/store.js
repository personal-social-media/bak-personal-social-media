import {createState} from '@hookstate/core';
import {buildSimpleAxios} from "../../lib/http/build-axios";
const registryAxios = buildSimpleAxios("https://registry.personalsocialmedia.net");

export const topSearchStore = createState({
  inputValue: '',
  searches: [],
  searching: false
});

export function search(value, state){
  let remoteSearchRunning = true,
    localSearchRunning = true;
  state.merge({searching: true});

  registryAxios.get(`/identities?q=${value}`).then(({data: { identities}}) => {
    if(false){

    }else{
      state.merge({searches: identities});
    }
  }).finally(() => {
    remoteSearchRunning = false;
  });
}