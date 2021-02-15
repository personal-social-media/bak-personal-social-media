import {Controller} from 'stimulus';
import {QRCodeCanvas} from '@cheprasov/qrcode';
import {downloadFile} from '../../lib/utils/download-file';

export default class extends Controller {
  connect() {
    this.addQrCode();
  }

  addQrCode() {
    const {element} = this;
    const qrCanvas = new QRCodeCanvas(element.dataset.qrCode, {level: 'Q', size: 360});
    const canvasWithQRCode = qrCanvas.getCanvas();
    element.appendChild(canvasWithQRCode);
    canvasWithQRCode.classList.add('cursor-pointer');

    canvasWithQRCode.addEventListener('click', () => {
      this.downloadFile(canvasWithQRCode);
    });
  }

  downloadFile(canvasWithQRCode) {
    downloadFile(canvasWithQRCode.toDataURL(), 'psm-recovery-code.png');
  }
}
