import {findIndex} from 'lodash';

export function goBackButton(currentElement, list, idProperty, state, currentElementProperty, destroyedProp) {
  const index = findIndex(list, (el) => {
    return el[idProperty].get() === currentElement[idProperty].get();
  });
  let nextIndex = index - 1;
  if (nextIndex === -1) nextIndex = list.length - 1;
  let backItem = list[nextIndex];

  while (backItem[idProperty].get() !== currentElement[idProperty].get()) {
    if (!backItem[destroyedProp].get()) {
      break;
    }
    backItem = list[nextIndex -= 1];
  }

  if (backItem[idProperty].get() === currentElement[idProperty].get()) {
    return;
  }

  state.merge({
    [currentElementProperty]: backItem.get(),
  });
}

export function goNextButton(currentElement, list, idProperty, state, currentElementProperty, destroyedProp) {
  const index = findIndex(list, (el) => {
    return el[idProperty].get() === currentElement[idProperty].get();
  });
  let nextIndex = index + 1;
  if (nextIndex === list.length) nextIndex = 0;

  let nextItem = list[nextIndex];

  while (nextItem[idProperty].get() !== currentElement[idProperty].get()) {
    if (!nextItem[destroyedProp].get()) {
      break;
    }
    nextItem = list[nextIndex += 1];
  }

  if (nextItem[idProperty].get() === currentElement[idProperty].get()) {
    return;
  }

  state.merge({
    [currentElementProperty]: nextItem.get(),
  });
}

export function destroyItem(currentElement, list, listPropertyName, idProperty, state, currentElementProperty, destroyedProp, modalOpenedProp) {
  const index = findIndex(list, (el) => {
    return el[idProperty].get() === currentElement[idProperty].get();
  });

  let nextIndex = index + 1;
  if (nextIndex === list.length) nextIndex = 0;

  let nextItem = list[nextIndex];

  while (nextItem && nextItem[idProperty].get() !== currentElement[idProperty].get()) {
    if (!nextItem[destroyedProp].get()) {
      break;
    }
    nextItem = list[nextIndex += 1];
  }

  if (nextItem[idProperty].get() === currentElement[idProperty].get() && modalOpenedProp) {
    return state.merge((s) => {
      return {
        [listPropertyName]: s[listPropertyName].map((el) => {
          if (el[idProperty] !== currentElement[idProperty].get()) return el;
          return {
            ...el,
            [destroyedProp]: true,
          };
        }),
        [modalOpenedProp]: false,
      };
    });
  }

  state.merge((s) => {
    return {
      [currentElementProperty]: nextItem.get(),
      [listPropertyName]: s[listPropertyName].map((el) => {
        if (el[idProperty] !== currentElement[idProperty].get()) return el;
        return {
          ...el,
          [destroyedProp]: true,
        };
      }),
    };
  });
}
