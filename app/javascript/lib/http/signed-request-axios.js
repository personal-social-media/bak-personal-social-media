import {Service} from 'axios-middleware';

export default function signedRequestAxios(instance) {
  const service = new Service(instance);

  service.register({
    onRequest(config) {
      console.log('onRequest');
      return config;
    },
    onResponse(response) {
      console.log('onResponse');
      return response;
    },
    onSync(promise) {
      console.log('onSync');
      return promise;
    },
  });

  return instance;
}
