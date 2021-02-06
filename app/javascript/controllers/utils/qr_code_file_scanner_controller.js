import QrScanner from 'qr-scanner';
QrScanner.WORKER_PATH = '/qr-scanner-worker.min.js';
import {Controller} from 'stimulus';
import {feedBackError} from '../../events/feedback';
import {feedbackSuccess} from '../../../snowpacker/events/feedback';

export default class extends Controller {
  static targets = ['output'];

  fileSelected(e) {
    const {target} = e;
    const file = target.files[0];
    QrScanner.scanImage(file).then((result) => {
      this.outputTarget.value = result;
      feedbackSuccess('QR code imported');
    }).catch(() => {
      feedBackError('Invalid qr code');
    }).finally(() => {
      target.type = 'text';
      target.type = 'file';
    });
  }
}
