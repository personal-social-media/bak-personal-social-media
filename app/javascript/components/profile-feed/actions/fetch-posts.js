export function fetchPosts(remoteAxios, startIndex, endIndex) {
  let url = '/posts';
  if (startIndex && endIndex) {
    url += `?start_index=${startIndex}&end_index=${endIndex}`;
  }

  return remoteAxios.get(url);
}
