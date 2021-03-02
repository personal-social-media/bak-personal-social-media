import {useLayoutEffect, useState} from 'react';

export function useDimensions(ref, deps) {
  const [dimensions, setDimensions] = useState({});

  useLayoutEffect(() => {
    if (!ref.current) return;

    setDimensions(ref.current.getBoundingClientRect());
  }, [ref, ...deps]); // eslint-disable-line react-hooks/exhaustive-deps

  return dimensions;
}
