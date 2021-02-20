import {Service} from 'axios-middleware';
import {addSignedUrlToCache, findSignedUrlFromCache} from './cache-signed-urls';
import {localAxios} from './build-axios';

export default function signedRequestAxios(instance) {
  const service = new Service(instance);

  service.register({
    async onRequest(config) {
      config.headers['Url-Signed'] = await getSignedUrl(config);
      return config;
    },
    onResponse(response) {
      return response;
    },
    onSync(promise) {
      return promise;
    },
  });

  return instance;
}

async function getSignedUrl(config) {
  const url = config.baseURL + config.url;
  const cached = findSignedUrlFromCache(url);
  if (cached) return cached;

  const response = await localAxios.post('/sign', {content: {url}});
  const {result} = response.data;
  addSignedUrlToCache(url, result);
  return result;
}
