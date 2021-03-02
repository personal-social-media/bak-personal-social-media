import {FilesPendingContext, fetchAllMd5Files, imageAlbumStore} from './store';
import {feedBackError} from '../../events/feedback';
import {useContext, useEffect} from 'react';
import {useState} from '@hookstate/core';
import Modal from '../utils/modal';
import SelectedFilesList from './upload/selected-files-list';
import UploadFileSelector from './upload/file-selector';

export default function ImageAlbumUpload({imageAlbumId}) {
  const [pendingFiles, setPendingFiles] = useContext(FilesPendingContext);
  const state = useState(imageAlbumStore);
  const opened = state.modalUploadOpened.get();

  useEffect(() => {
    fetchAllMd5Files().then(({data: {md5Checksums}}) => {
      setPendingFiles({
        ...pendingFiles,
        alreadySavedMd5CheckSums: md5Checksums,
      });
    }).catch(() => {
      feedBackError('Unable to load md5 list');
    });
  }, [setPendingFiles]); // eslint-disable-line react-hooks/exhaustive-deps

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

      <Modal opened={opened} setOpened={setModalOpened} modalStyle={{marginTop: '1rem', width: '60%'}}>
        {
          state.modalUploadOpened && <div>
            <div className="text-center mb-4">
              <h3 className="mb-2">Upload more files</h3>
              {
                opened && <UploadFileSelector imageAlbumId={imageAlbumId}/>
              }
            </div>

            {
              opened && <SelectedFilesList/>
            }
          </div>
        }
      </Modal>
    </div>
  );
}
