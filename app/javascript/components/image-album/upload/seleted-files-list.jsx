import {CellMeasurer,
  CellMeasurerCache,
  Masonry,
  createMasonryCellPositioner,
} from 'react-virtualized';
import {FilesPendingContext} from '../store';
import {useContext, useMemo} from 'react';
import SelectedFile from './selected-file';

export default function SelectedFilesList({realWidth, columns, width, height}) {
  const [pendingFilesForUpload, setPendingFilesForUpload] = useContext(FilesPendingContext);

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

  function remove(pendingFile) {
    setPendingFilesForUpload(pendingFilesForUpload.filter((p) => {
      return p !== pendingFile;
    }));
  }

  return (
    <Masonry
      cellCount={pendingFilesForUpload.length}
      cellMeasurerCache={computed.cache}
      cellPositioner={computed.cellPositioner}
      className="outline-none"
      cellRenderer={({index, key, parent, style}) => {
        const pendingFile = pendingFilesForUpload[index];
        if (!pendingFile) return null;

        return (
          <CellMeasurer
            cache={computed.cache}
            index={index}
            key={key}
            parent={parent}
          >
            <div style={style}>
              <SelectedFile remove={remove} pendingFile={pendingFile} realWidth={realWidth}/>
            </div>
          </CellMeasurer>
        );
      }}
      height={height}
      width={width}
    />
  );
}
