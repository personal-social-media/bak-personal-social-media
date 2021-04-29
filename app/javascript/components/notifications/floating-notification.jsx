import {containerStyle} from './floating-notification.module.scss';
import mergeStyles from "../../lib/utils/string/merge-styles";
import {isEmpty} from 'lodash';
import NotificationItem from "./notification-item";
import { useTimeoutFn } from 'react-use';

export default function FloatingNotification({state}){
  const containerClassName = mergeStyles(containerStyle, "fixed bg-white shadow-xl");

  if(isEmpty(state.latestNotification)) return null;
  if(state.opened.get()) return null;

  return(
    <div className={containerClassName}>
      <FloatingNotificationContent state={state}/>
    </div>
  )
}

function FloatingNotificationContent({state}){
  const [_, cancel, reset] = useTimeoutFn(() => {
    state.merge({
      latestNotification: null
    });
  }, 5000);

  return(
    <div onMouseEnter={cancel} onMouseLeave={reset}>
      <NotificationItem data={state.latestNotification} isFloating/>
    </div>
  )
}