const mediaRegex = /\.(jpe?g|png|gif|bmp|webp|mp4)$/i;

function customHeaderRequestFetch(event) {
  const {request} = event;
  const {url} = request;
  if(!url.match(mediaRegex)) return fetch(request);

  const newRequest = new Request(request, {
    headers: {
      'Real-User-Agent': 'Personal Social Media',
    },
    mode: 'cors'
  });
  return fetch(newRequest)
}