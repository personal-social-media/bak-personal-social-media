export function getProperties(proxy, ...properties) {
  const result = {};
  properties.forEach((p) => {
    result[p] = proxy[p].get();
  });

  return result;
}
