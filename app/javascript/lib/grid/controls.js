import {findIndex} from 'lodash';

export function goBackButton(currentElement, list, idProperty, state, currentElementProperty, destroyedProp) {
  const index = findIndex(list, (el) => {
    return el[idProperty] === currentElement[idProperty];
  });
  let nextIndex = index - 1;
  if (nextIndex === -1) nextIndex = list.length - 1;
  let backItem = list[nextIndex];

  while (backItem[idProperty] !== currentElement[idProperty]) {
    if (!backItem[destroyedProp]) {
      break;
    }
    backItem = list[nextIndex -= 1];
  }

  if (backItem[idProperty] === currentElement[idProperty]) {
    return;
  }

  state.merge({
    [currentElementProperty]: backItem,
  });
}

export function goNextButton(currentElement, list, idProperty, state, currentElementProperty, destroyedProp) {
  const index = findIndex(list, (el) => {
    return el[idProperty] === currentElement[idProperty];
  });
  let nextIndex = index + 1;
  if (nextIndex === list.length) nextIndex = 0;

  let nextItem = list[nextIndex];

  while (nextItem[idProperty] !== currentElement[idProperty]) {
    if (!nextItem[destroyedProp]) {
      break;
    }
    nextItem = list[nextIndex += 1];
  }

  if (nextItem[idProperty] === currentElement[idProperty]) {
    return;
  }

  state.merge({
    [currentElementProperty]: nextItem,
  });
}

export function destroyItem(currentElement, list, listPropertyName, idProperty, state, currentElementProperty, destroyedProp, modalOpenedProp) {
  let nextIndex = findIndex(list, (el) => {
    return el[idProperty] === currentElement[idProperty];
  });

  nextIndex += 1;
  if (nextIndex === list.length) nextIndex = 0;

  let nextItem = list[nextIndex];

  while (nextItem[idProperty] !== currentElement[idProperty]) {
    if (!nextItem[destroyedProp]) {
      break;
    }
    nextItem = list[nextIndex += 1];
  }

  if (nextItem[idProperty] === currentElement[idProperty] && modalOpenedProp) {
    return state.merge((s) => {
      return {
        [listPropertyName]: s[listPropertyName].map((el) => {
          if (el[idProperty] !== currentElement[idProperty]) return el;
          return {
            ...el,
            [destroyedProp]: true,
          };
        }),
        [modalOpenedProp]: true,
      };
    });
  }

  state.merge((s) => {
    return {
      [currentElementProperty]: nextItem,
      [listPropertyName]: s[listPropertyName].map((el) => {
        if (el[idProperty] !== currentElement[idProperty]) return el;
        return {
          ...el,
          [destroyedProp]: true,
        };
      }),
    };
  });
}
