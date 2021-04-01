export function addListenerMultiEvents(element, eventNames, listener, options = {}) {
  const events = eventNames.split(' ');
  events.forEach((e) => {
    element.addEventListener(e, listener, options);
  });
}
