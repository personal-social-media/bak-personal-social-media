import {feedBackErrorLog} from '../../events/feedback';
import {getProperties} from '../../lib/utils/get-properties';
import {isEmpty} from 'lodash';
import {markNotificationsAsSeen} from './store';
import {notificationStyle, iconStyle} from './notification-item.module.css';
import mergeStyles from '../../lib/utils/string/merge-styles';

export default function NotificationItem({data: notification, isFloating = false}) {
  const {id, seen, url, imageUrl, message, icon} = getProperties(notification, 'id', 'seen', 'message', 'imageUrl', 'url', 'icon');

  const floatingStyleSpecific = isFloating ? "" : "hover:bg-gray-200";
  const className = mergeStyles('p-2 overflow-hidden flex items-center rounded-lg cursor-pointer', notificationStyle, floatingStyleSpecific);

  async function openUrl(e) {
    if (isEmpty(url)) e.preventDefault();

    try {
      await markNotificationsAsSeen([id]);
      notification.merge({seen: true});
    } catch {
      feedBackErrorLog('Unable to mark notification as seen');
    }
  }

  return (
    <a className={className} href={url} onClick={openUrl}>
      <div className="relative">
        <img src={imageUrl} alt="notification" className="h-16 w-16 rounded-full"/>
        <i className={mergeStyles(icon, iconStyle, "absolute right-0 bottom-0 p-1 rounded-full h-8 w-8")}/>
      </div>
      <div className="flex justify-between ml-2 text-gray-700 flex-1 items-center">
        <div>
          {message}
        </div>

        {
          (!seen && !isFloating) && <div>
            <div className="bg-blue-600 h-4 w-4 rounded-full"/>
          </div>
        }
      </div>
    </a>
  );
}
