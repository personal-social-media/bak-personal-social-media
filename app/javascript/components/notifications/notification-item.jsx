import {notificationStyle} from './notification-item.module.css';

export default function NotificationItem({data: notification, state}) {
  return (
    <div className={`bg-red-400 ${notificationStyle}`}>
      ok
    </div>
  );
}
