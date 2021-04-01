import {ActionCableContext} from '../../lib/hooks/use-action-cable';
import {addListenerMultiEvents} from '../../lib/utils/events/listen-multiple-events';
import {createConsumer} from '@rails/actioncable/src';
import {useEffect, useState} from 'react';
let connCached;

export default function ActionCable({children}) {
  const [conn, setConn] = useState(connCached);

  useEffect(() => {
    if (conn) return;
    connCached = createConsumer('/cable');
    setConn(connCached);

    addListenerMultiEvents(window, 'turbolinks:before-cache turbolinks:before-render', () => {
      if (!connCached) return;
      connCached.disconnect();
      connCached = null;
    }, {once: true});
  }, []); // eslint-disable-line react-hooks/exhaustive-deps

  return (
    <ActionCableContext.Provider value={{conn}}>
      {children}
    </ActionCableContext.Provider>
  );
}
