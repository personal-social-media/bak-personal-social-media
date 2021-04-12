import {Controller} from 'stimulus';

export default class extends Controller {
  static targets = ["input", "icon"];

  toggle(){
    const {type} = this.inputTarget;
    const {classList: iconClassList } = this.iconTarget;
    if(type === "text"){
      this.inputTarget.type = "password";
      iconClassList.remove("fa-eye-slash");
      return iconClassList.add("fa-eye");
    }

    this.inputTarget.type = "text";
    iconClassList.remove("fa-eye");
    return iconClassList.add("fa-eye-slash");
  }
}