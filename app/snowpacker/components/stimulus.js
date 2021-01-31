import { Application } from "stimulus"
import UtilsQrCode from "./utils/qr-code";
import UtilsDropDown from "./utils/drop-down";
import Modal from "./utils/modal";
import CreatePostModal from "./posts/create-modal";
import FormTextArea from "./forms/textarea";
import FormAttachmentsImage from "./form_attachments/image";


const application = Application.start();
application.register("utils-qr-code", UtilsQrCode);
application.register("utils-drop-down", UtilsDropDown);
application.register("modal", Modal);
application.register("create-post-modal", CreatePostModal);
application.register("textarea", FormTextArea);
application.register("form-attachment-image", FormAttachmentsImage);
