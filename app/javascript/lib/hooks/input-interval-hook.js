import {useState} from 'react';
import useInterval from 'use-interval';

export default function useInputIntervalHook(watchedValue, intervalTime, initialValue, cb) {
  const [delayedValue, setDelayedValue] = useState(initialValue);

  useInterval(() => {
    const watchedValueGet = watchedValue.get();
    if (delayedValue !== watchedValueGet) {
      setDelayedValue(watchedValueGet);
      cb(watchedValueGet);
    }
  }, intervalTime);
}
