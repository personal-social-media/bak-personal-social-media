import {getImageForDevice, userPlaceholder} from '../../lib/device/device-type';

export default function UserAvatar({avatars, username, imageOptions = {}}) {
  const {type} = avatars;

  if (type === 'image') {
    return (
      <img src={getImageForDevice(avatars, userPlaceholder)} alt={username} {...imageOptions}/>
    );
  }

  return null;
}
