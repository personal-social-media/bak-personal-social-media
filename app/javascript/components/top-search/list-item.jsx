import {getImageForDevice, userPlaceholder} from '../../lib/device/device-type';

export default function SearchListItem({identity}) {
  const avatar = getImageForDevice(identity.avatars, userPlaceholder);

  return (
    <div className="flex items-center">
      <img src={avatar} alt={identity.username} className="h-10 w-10 rounded-full object-cover"/>

      <div className="ml-1 text-gray-700 text-lg">
        {identity.username}
      </div>
    </div>
  );
}
