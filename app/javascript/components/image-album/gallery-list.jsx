import {CellMeasurer,
  CellMeasurerCache,
  Masonry,
  createMasonryCellPositioner,
} from 'react-virtualized';
import {imageAlbumStore} from './store';
import {useMemo} from 'react';
import {useState} from '@hookstate/core';
import GalleryImageFile from './gallery-image-file';
import GalleryVideoFile from './gallery-video-file';

export default function GalleryList({realWidth, columns, width, height}) {
  const state = useState(imageAlbumStore);
  const galleryElements = state.galleryElements.get();

  const computed = useMemo(() => {
    const cache = new CellMeasurerCache({
      defaultWidth: realWidth,
      fixedWidth: true,
    });

    const cellPositioner = createMasonryCellPositioner({
      cellMeasurerCache: cache,
      columnCount: columns,
      columnWidth: realWidth - 10,
      spacer: 10,
    });

    return {cache, cellPositioner};
  }, [realWidth, columns]);


  return (
    <Masonry
      cellCount={galleryElements.length}
      cellMeasurerCache={computed.cache}
      cellPositioner={computed.cellPositioner}
      className="outline-none"
      cellRenderer={({index, key, parent, style}) => {
        const galleryElement = galleryElements[index];

        return (
          <CellMeasurer
            cache={computed.cache}
            index={index}
            key={key}
            parent={parent}
          >
            <div style={style}>
              {
                galleryElement.element.type === 'imagefile' &&
                <GalleryImageFile state={state} galleryElement={galleryElement} realWidth={realWidth - 10}/>
              }

              {
                galleryElement.element.type === 'videofile' &&
                <GalleryVideoFile state={state} galleryElement={galleryElement} realWidth={realWidth - 10}/>
              }
            </div>
          </CellMeasurer>
        );
      }}
      height={height}
      width={width}
    />
  );
}
