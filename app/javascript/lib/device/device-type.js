import _userPlaceholder from '../../images/profiles/placeholder.svg';

export const deviceType = window.orientation ? 'mobile' : 'desktop';

export function getImageForDevice(image, placeholder) {
  if (!image) return placeholder;
  return image[deviceType];
}

export const userPlaceholder = _userPlaceholder;
