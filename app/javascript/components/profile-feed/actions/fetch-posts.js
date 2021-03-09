export function fetchPosts(remoteAxios, state, page = 1) {
  return remoteAxios.get('/posts');
}
