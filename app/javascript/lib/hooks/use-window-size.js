import {useCallback, useEffect, useState} from 'react';

export default function useWindowSize() {
  const isClient = typeof window === 'object';

  const getSize = useCallback(() => {
    return {
      height: isClient ? window.innerHeight : undefined,
      isMobile: isClient ? window.innerWidth < 950 : undefined,
      width: isClient ? window.innerWidth : undefined,
    };
  }, [isClient]);

  const [windowSize, setWindowSize] = useState(getSize);

  useEffect(() => {
    if (!isClient) {
      return false;
    }

    function handleResize() {
      setWindowSize(getSize());
    }

    window.addEventListener('resize', handleResize);
    return () => window.removeEventListener('resize', handleResize);
  }, [getSize, isClient]);

  return windowSize;
}
