export function formatUploadPercentage(progressEvent) {
  const result = (progressEvent.loaded * 100) / progressEvent.total;
  return parseFloat(result.toFixed(2));
}
