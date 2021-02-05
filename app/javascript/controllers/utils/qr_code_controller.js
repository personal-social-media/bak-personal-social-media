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
    canvasWithQRCode.classList.add("cursor-pointer");

    canvasWithQRCode.addEventListener("click", () => {
      this.downloadFile(canvasWithQRCode);
    });
  }

  downloadFile(canvasWithQRCode){
    const a = document.createElement('a');
    a.href = canvasWithQRCode.toDataURL();
    a.download = "psm-recovery-code.png";
    document.body.appendChild(a);
    a.click();
    document.body.removeChild(a);
  }
}
