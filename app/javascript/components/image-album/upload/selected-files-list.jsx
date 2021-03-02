import {FilesPendingContext, filesPendingContextDefault} from '../store';
import {useCallback, useRef} from 'react';
import {useContext, useEffect} from 'react';
import {useDimensions} from '../../../lib/hooks/use-dimensions';
import {useState} from 'react';
import SelectedFile from './selected-file';
import SelectedFilesListMasonry from './selected-file-list-masonry';
import prettyBytes from 'pretty-bytes';
import useWindowSize from '../../../lib/hooks/use-window-size';

export default function SelectedFilesList() {
  const [{availableFiles, files, uploadManager}, setPendingFiles] = useContext(FilesPendingContext);
  const [totalFilesSize, setTotalFileSize] = useState(null);

  useEffect(() => {
    if (!uploadManager) return;

    setTotalFileSize(prettyBytes(uploadManager.totalSize()));
  }, [setTotalFileSize, availableFiles, uploadManager]);

  const {isMobile} = useWindowSize();
  const columns = isMobile ? 2 : 12;
  const topContainerRef = useRef(null);
  const {width, height} = useDimensions(topContainerRef, [files.length]);

  useEffect(() => {
    return () => {
      setPendingFiles(filesPendingContextDefault);
    };
  }, [setPendingFiles]);

  const SelectedFileWrapper = useCallback((props) => {
    return (
      <SelectedFile {...props} uploadManager={uploadManager}/>
    );
  }, [uploadManager]);


  return (
    <div>
      {
        availableFiles.length > 0 && <div className="text-gray-600 mb-2">
          Total: {availableFiles.length} selected files - {totalFilesSize}
        </div>
      }

      <div className="overflow-hidden" style={{height: '75vh'}}>
        <div className="overflow-y-scroll" style={{height: '75vh'}} ref={topContainerRef}>
          <SelectedFilesListMasonry
            items={files}
            render={SelectedFileWrapper}
            columnCount={columns}
            columnGutter={4}
            estimateHeight={150}
            topContainerRef={topContainerRef}
            height={height}
            width={width}
          />
        </div>
      </div>
    </div>
  );
}
