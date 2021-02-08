import {deviceType} from '../device/device-type';
import applyCaseMiddleware from 'axios-case-converter';
import axios from 'axios';
import signedRequestAxios from './signed-request-axios';

export function buildLocalAxios() {
  const instance = axios.create({
    baseURL: '',
    headers: {
      'X-CSRF-Token': document.querySelector('meta[name=\'csrf-token\']').content,
    },
  });
  return applyCaseMiddleware(instance);
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

