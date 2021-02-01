export default function domReady(cb) {
  document.addEventListener('turbolinks:load', cb);
}
