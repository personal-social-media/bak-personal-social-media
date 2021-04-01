import {createContext, useContext, useEffect} from 'react';
export const ActionCableContext = createContext();

export const useActionCable = (params, handlers = {}) => {
  const {conn} = useContext(ActionCableContext);

  const diff = JSON.stringify({params, url: conn && conn._url});

  useEffect(() => {
    let subscription;

    if (params && conn) {
      subscription = conn.subscriptions.create(params, handlers);
    }

    return () => subscription && subscription.unsubscribe();
  }, [diff, conn, params, handlers]);
};
