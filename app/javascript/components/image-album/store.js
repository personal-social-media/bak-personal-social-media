import {createContext} from 'react';
import {createState} from '@hookstate/core';
import {localAxios} from '../../lib/http/build-axios';

export const defaultImageAlbumStore = {
  currentGalleryElement: null,
  galleryElements: null,
  modalOpened: false,
  modalUploadOpened: false,
  pendingUploadFiles: [],
  pendingUploadFilesManager: null,
  pendingUploadFilesSize: 0,
};

export const imageAlbumStore = createState({
  ...defaultImageAlbumStore,
});
export const FilesPendingContext = createContext(null);
export const filesPendingContextDefault = {
  alreadySavedMd5CheckSums: [],
  availableFiles: [],
  currentUploadSize: null,
  files: [],
  status: null,
  statusMessage: null,
  uploadManager: null,
  uploadPercentage: null,
};

export function fetchGalleryElements(imageAlbumId, startIndex, endIndex) {
  let url = `/image_albums/${imageAlbumId}/gallery_elements`;
  if (startIndex && endIndex) {
    url += `?start_index=${startIndex}&end_index=${endIndex}`;
  }
  return localAxios.get(url);
}

export function fetchAllMd5Files() {
  return localAxios.get('/gallery_elements/all_md5_checksums');
}
