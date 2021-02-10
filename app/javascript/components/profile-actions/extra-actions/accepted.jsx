import {useState} from 'react';
import Modal from '../../utils/modal';
import Unfriend from './accepted/unfriend';

export default function ExtraActionsAccepted() {
  const [modalOpened, setModalOpened] = useState(false);

  function open() {
    setModalOpened(true);
  }

  return (
    <div>
      <i className="fa fa-ellipsis-v fa-2x cursor-pointer" onClick={open}/>
      <Modal opened={modalOpened} setOpened={setModalOpened}>
        <Unfriend/>
      </Modal>
    </div>
  );
}
