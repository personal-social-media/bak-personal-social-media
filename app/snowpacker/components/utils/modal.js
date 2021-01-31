import {Controller} from "stimulus";

export default class Modal extends Controller {
  static targets = ["content", "background"]

  toggle(){
    this.backgroundTarget.classList.toggle("inset-0");
    this.backgroundTarget.classList.toggle("hidden");
    this.contentTarget.classList.toggle("inset-0");
    this.contentTarget.classList.toggle("hidden");
    document.body.classList.toggle("overflow-y-hidden");
  }

  close(e){
    if(!e.target.matches(".modal-container")){
      return;
    }

    this.toggle();
  }

  forceClose(e){
    e.preventDefault();

    this.toggle();
  }
}