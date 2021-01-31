import { Controller } from 'stimulus';
import { QRCodeCanvas } from '@cheprasov/qrcode';

export default class UtilsQrCode extends Controller {
  connect(){
    this.addQrCode();
  }

  addQrCode(){
    const { element } = this;
    const qrCanvas = new QRCodeCanvas(element.dataset.qrCode, { size: 360, level: "Q"});
    const canvasWithQRCode = qrCanvas.getCanvas();
    element.appendChild(canvasWithQRCode);
  }
}