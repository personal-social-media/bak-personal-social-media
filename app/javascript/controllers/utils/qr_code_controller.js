import {Controller} from 'stimulus';
import {QRCodeCanvas} from '@cheprasov/qrcode';
import {downloadFile} from '../../lib/utils/download-file';

export default class extends Controller {
  connect() {
    this.addQrCode();
  }

  async addQrCode() {
    const {element} = this;
    const qrCanvas = new QRCodeCanvas(element.dataset.qrCode, this.qrOptions());
    const canvasWithQRCode = await qrCanvas.getCanvas();

    element.appendChild(canvasWithQRCode);
    canvasWithQRCode.classList.add('cursor-pointer');

    canvasWithQRCode.addEventListener('click', () => {
      this.downloadFile(canvasWithQRCode);
    });
  }

  downloadFile(canvasWithQRCode) {
    downloadFile(canvasWithQRCode.toDataURL(), this.getFileName());
  }

  getFileName() {
    const dataFileName = this.element.dataset.fileName;
    if (dataFileName === 'location') {
      return location.host + '.png';
    }
    return dataFileName;
  }

  qrOptions() {
    const options = {
      level: 'Q', size: 360,
    };

    const image = this.element.dataset.source;
    if (image) {
      options.image = {
        height: '20%',
        source: image,
        width: '20%',
        x: 'center',
        y: 'center',
      };
    }

    return options;
  }
}
