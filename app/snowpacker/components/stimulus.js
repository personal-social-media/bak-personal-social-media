import { Application } from "stimulus"
import UtilsQrCode from "./utils/qr-code";
import UtilsDropDown from "./utils/drop-down";


const application = Application.start();
application.register("utils-qr-code", UtilsQrCode);
application.register("utils-drop-down", UtilsDropDown);
