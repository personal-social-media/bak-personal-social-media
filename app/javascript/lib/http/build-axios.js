import {getDeviceType} from '../device/device-type';
import applyCaseMiddleware from 'axios-case-converter';
import axios from 'axios';
import signedRequestAxios from './signed-request-axios';

export function buildLocalAxios() {
  let instance = axios.create({
    baseURL: '',
    headers: {
      'X-CSRF-Token': document.querySelector('meta[name=\'csrf-token\']').content,
    },
  });
  instance = applyCaseMiddleware(instance);
  return instance;
}

export function buildRemoteAxios(target) {
  const protocol = process.env.RAILS_ENV === 'production' ? 'https' : 'http';
  if(process.env.RAILS_ENV !== 'production' && target === "localhost"){
    target = "localhost:3000"
  }

  let instance = axios.create({
    baseURL: `${protocol}://${target}/api`,
    headers: {
      'Client': getDeviceType(),
      'Public-Key': document.querySelector('meta[name=\'public-key\']').content,
      'Real-User-Agent': 'Personal Social Media',
    },
  });
  instance = applyCaseMiddleware(instance);
  return signedRequestAxios(instance);
}

