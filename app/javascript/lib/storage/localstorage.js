import localforage from 'localforage';

export const localStorageWrapper = localforage.createInstance({
  name: 'app',
});
