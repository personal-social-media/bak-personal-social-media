export function getDeviceType() {
  if (!window.orientation) {
    return 'desktop';
  }

  return 'mobile';
}
