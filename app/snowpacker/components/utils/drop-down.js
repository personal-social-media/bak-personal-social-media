import {Controller} from "stimulus";

export default class UtilsDropDown extends Controller {
  static targets = ["dropdown"];

  connect(){
    this.listedClickOutside();
  }

  toggleOpen(){
    if(this.opened){
      return this.close();
    }

    this.open();
  }

  open(){
    this.opened = true;
    const { classList } = this.dropdownTarget;
    classList.remove("invisible", "opacity-0");
    classList.add("visible", "opacity-1");
  }

  close(){
    this.opened = false;
    const { classList } = this.dropdownTarget;
    classList.remove("visible", "opacity-1");
    classList.add("invisible", "opacity-0");
  }

  listedClickOutside(){
    document.addEventListener("click", (e) => {
      if(!this.opened || this.element.contains(e.target)){
        return;
      }

      this.close();
    });
  }
}