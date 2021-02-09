const cache = {}; const cacheOrder = [];
let cacheCount = 0;

export function addSignedUrlToCache(url, signedUrl) {
  cache[url] = signedUrl;
  cacheOrder.push(url);
  cacheCount += 1;
  clearCache();
}

export function findSignedUrlFromCache(url) {
  return cache[url];
}

function clearCache() {
  if (cacheCount !== 200) return;
  cacheCount = 100;
  const toBeRemoved = cacheOrder.splice(0, 99);
  toBeRemoved.forEach((cacheItem) => {
    delete cache[cacheItem];
  });
}
