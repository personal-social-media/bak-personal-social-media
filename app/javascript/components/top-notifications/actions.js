import {localAxios} from '../../lib/http/build-axios';

export function resetNotSeenNotificationsCounter(notificationsNotSeenCount) {
  if (notificationsNotSeenCount < 1) return;

  return localAxios.post('/profile/reset_counter', {profile: {counter: 'not_seen_notifications_count'}});
}
