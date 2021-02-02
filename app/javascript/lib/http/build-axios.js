import applyCaseMiddleware from 'axios-case-converter';
import axios from 'axios';
import signedRequestAxios from './signed-request-axios';

export function buildLocalAxios() {
  let instance = axios.create({
    baseURL: '/',
  });
  instance = applyCaseMiddleware(instance);
  return instance;
}

export function buildRemoteAxios(target) {
  let instance = axios.create({
    baseURL: `https://${target}/api`,
  });
  instance = applyCaseMiddleware(instance);
  instance = signedRequestAxios(instance);
  return instance;
}

