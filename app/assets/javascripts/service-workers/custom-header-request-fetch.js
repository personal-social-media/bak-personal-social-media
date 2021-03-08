const mediaRegex = /\/uploads\//;

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