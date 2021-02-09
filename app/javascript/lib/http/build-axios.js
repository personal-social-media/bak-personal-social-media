import {deviceType} from '../device/device-type';
import applyCaseMiddleware from 'axios-case-converter';
import axios from 'axios';
import signedRequestAxios from './signed-request-axios';

let _localAxios;
export function buildLocalAxios() {
  if (_localAxios) {
    return _localAxios;
  }
  _localAxios = axios.create({
    baseURL: '',
    headers: {
      'X-CSRF-Token': document.querySelector('meta[name=\'csrf-token\']').content,
    },
  });
  return _localAxios = applyCaseMiddleware(_localAxios);
}

export function buildRemoteAxios(target) {
  let protocol = 'https';
  if (process.env.RAILS_ENV !== 'production' && target === 'localhost') {
    target = 'localhost:3000';
    protocol = 'http';
  }

  let instance = axios.create({
    baseURL: `${protocol}://${target}/api`,
    headers: {
      'Client': deviceType,
      'Gateway': document.querySelector('meta[name=\'gateway\']').content,
      'Public-Key': document.querySelector('meta[name=\'public-key\']').content,
      'Real-User-Agent': 'Personal Social Media',
    },
  });
  instance = applyCaseMiddleware(instance);
  return signedRequestAxios(instance);
}

export function buildSimpleAxios(target) {
  const instance = axios.create({
    baseURL: target,
  });

  return applyCaseMiddleware(instance);
}

