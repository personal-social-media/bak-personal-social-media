import {Controller} from 'stimulus';
import {QRCodeCanvas} from '@cheprasov/qrcode';

export default class extends Controller {
  connect() {
    this.addQrCode();
  }

  addQrCode() {
    const {element} = this;
    const qrCanvas = new QRCodeCanvas(element.dataset.qrCode, {level: 'Q', size: 360});
    const canvasWithQRCode = qrCanvas.getCanvas();
    element.appendChild(canvasWithQRCode);
  }
}
