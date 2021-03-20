export function intToString(value) {
  const suffixes = ['', 'k', 'm', 'b', 't'];
  const suffixNum = Math.floor(('' + value).length / 3);
  let shortValue = parseFloat((suffixNum !== 0 ? (value / Math.pow(1000, suffixNum)) : value).toPrecision(2));
  if (shortValue % 1 !== 0) {
    shortValue = shortValue.toFixed(1);
  }
  return shortValue+suffixes[suffixNum];
}

function intlFormat(num) {
  return new Intl.NumberFormat().format(Math.round(num*10)/10);
}

export function makeFriendlyNumber(num) {
  if (num >= 1000000) {
    return intlFormat(num/1000000)+'M';
  }
  if (num >= 1000) {
    return intlFormat(num/1000)+'k';
  }
  return intlFormat(num);
}
