import {Controller} from "stimulus";

export default class CreateModal extends Controller {
  static targets = ["textarea"];

  open(){
    this.textareaTarget.focus();
  }
}