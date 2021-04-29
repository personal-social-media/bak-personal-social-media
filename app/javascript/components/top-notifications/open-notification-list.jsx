import {deviceType} from '../../lib/device/device-type';
import {feedBackErrorLog} from '../../events/feedback';
import {listStyle} from './open-notification-list.module.scss';
import {resetNotSeenNotificationsCounter} from './actions';
import {useRef} from 'react';
import NotificationsListTop from '../notifications/notifications-list-top';
import NotificationsLoader from '../notifications/notifications-loader';
import OutsideClickHandler from 'react-outside-click-handler';
import mergeStyles from '../../lib/utils/string/merge-styles';

export default function OpenNotificationsList({state, children}) {
  const containerRef = useRef();
  async function open(e) {
    e.preventDefault();
    const prevNotificationsNotSeenCount = state.notificationsNotSeenCount.get();
    state.batch((s) => {
      s.notificationsNotSeenCount.set(0);

      if (deviceType === 'mobile') return Turbolinks.visit('/mobile/notifications');
      s.merge({
        firstTimeOpened: true,
        opened: true,
        latestNotification: null
      });
    });

    try {
      await resetNotSeenNotificationsCounter(prevNotificationsNotSeenCount);
    } catch {
      feedBackErrorLog('unable to reset not seen counter');
    }
  }

  const openedClassName = state.opened.get() ? 'visible opacity-1' : 'invisible opacity-0';
  const listClassName = mergeStyles(listStyle, 'fixed bg-white rounded-lg shadow-xl overflow-y-scroll p-1', openedClassName);

  return (
    <>
      <button onClick={open} className="focus:no-outline">
        {children}
      </button>

      {
        deviceType !== 'mobile' && <div className={listClassName} ref={containerRef}>
          <OutsideClickHandler onOutsideClick={() => state.opened.set(false)}>
            {
              state.firstTimeOpened.get() && <NotificationsLoader>
                <NotificationsListTop topContainerRef={containerRef}/>
              </NotificationsLoader>
            }
          </OutsideClickHandler>
        </div>
      }
    </>
  );
}
