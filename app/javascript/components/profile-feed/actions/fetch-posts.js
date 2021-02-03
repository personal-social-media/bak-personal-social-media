export function fetchPosts(remoteAxios, state, page = 1) {
  remoteAxios.get('/posts').then(({data: {posts}}) => {
    state.merge({posts: posts});
  });
}
