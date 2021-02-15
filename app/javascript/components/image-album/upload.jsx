import {AutoSizer} from 'react-virtualized';
import {imageAlbumStore} from './store';
import {useState} from '@hookstate/core';
import Modal from '../utils/modal';
import SelectedFilesList from './upload/seleted-files-list';
import UploadFileSelector from './upload/file-selector';

export default function ImageAlbumUpload() {
  const state = useState(imageAlbumStore);
  const columns = 4;

  function setModalOpened(modalUploadOpened) {
    state.merge({
      modalUploadOpened,
    });
  }

  return (
    <div>
      <button className="flex items-center" onClick={(e) => {
        e.preventDefault();
        setModalOpened(true);
      }}>
        <i className="fa fa-upload fa-2x text-gray-700 hover:text-gray-600"/>
        <span className="ml-1">
          Upload more
        </span>
      </button>

      <Modal opened={state.modalUploadOpened.get()} setOpened={setModalOpened}>
        {
          state.modalUploadOpened && <div>
            <div>
              <h3>Upload more files</h3>
            </div>

            <div>
              <UploadFileSelector/>
            </div>

            <div style={{height: '40rem', width: '100%'}}>
              <AutoSizer>
                {({width, height}) => {
                  if (height < 1 || width < 1) return null;
                  return <SelectedFilesList realWidth={width / columns} columns={columns} width={width} height={height}/>;
                }}
              </AutoSizer>
            </div>
          </div>
        }
      </Modal>
    </div>
  );
}
