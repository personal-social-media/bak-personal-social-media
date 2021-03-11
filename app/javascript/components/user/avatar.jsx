import {getImageForDevice, userPlaceholder} from '../../lib/device/device-type';

export default function UserAvatar({avatars, username, imageOptions = {}}) {
  if (!avatars) {
    return (
      <PlaceHolderAvatar username={username} imageOptions={imageOptions}/>
    );
  }
  const {type} = avatars;

  if (type === 'image') {
    return (
      <img src={getImageForDevice(avatars, userPlaceholder)} alt={username} {...imageOptions}/>
    );
  }

  return (
    <PlaceHolderAvatar username={username} imageOptions={imageOptions}/>
  );
}


function PlaceHolderAvatar({username, imageOptions}) {
  return (
    <img src={userPlaceholder} alt={username} {...imageOptions}/>
  );
}
