export function shortFileName(name, max = 8) {
  const splitName = name.split('.');
  const ext = splitName[splitName.length - 1];
  const real = splitName[0];
  const middle = real.length / 2;
  const firstPart = real.substring(0, middle);
  const lastPart = real.substring(middle, real.length);

  let filename;

  if (real.length > max) {
    filename = `${firstPart.substring(0, max /2)}..${lastPart.slice(lastPart.length - (max / 2))}`;
  } else {
    filename = real;
  }

  return `${filename}.${ext}`;
}
