export default function domReady(cb){
  document.addEventListener("turbo:load", cb);
}