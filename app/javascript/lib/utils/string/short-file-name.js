export function shortFileName(name, max = 8){
  const splitName = name.split(".");
  const ext = splitName[splitName.length - 1];
  const real = splitName[0];
  let filename;
  if(real.length > 8){
    filename = `${real.substring(0, (max -1) / 2)}..${real.substring(real.length - (max / 2), real.length)}`
  }else{
    filename = real;
  }

  return `${filename}.${ext}`
}