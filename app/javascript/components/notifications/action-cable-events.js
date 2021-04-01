import {useActionCable} from '../../lib/hooks/use-action-cable';

export default function NotificationsActionCableEvents({children}) {
  const channelHandlers = {
    received(data) {
      console.log(data);
    },
  };

  const channelParams = {channel: 'NotificationsChannel'};
  useActionCable(channelParams, channelHandlers);

  return children;
}
