// reference
// https://chris-miceli.blogspot.com/2014/05/base32-decoding-in-javascript.html

/* eslint-disable no-throw-literal */
const alphabet = 'abcdefghijklmnopqrstuvwxyz234567';

export function decodeBase32(base32EncodedString) {
  if (!base32EncodedString && base32EncodedString !== '') {
    throw 'base32EncodedString cannot be null or undefined';
  }

  if (base32EncodedString.length * 5 % 8 !== 0) {
    throw 'base32EncodedString is not of the proper length. Please verify padding.';
  }

  base32EncodedString = base32EncodedString.toLowerCase();
  let returnArray = new Array(base32EncodedString.length * 5 / 8);

  let currentByte = 0;
  let bitsRemaining = 8;
  let mask = 0;
  let arrayIndex = 0;

  for (let count = 0; count < base32EncodedString.length; count++) {
    const currentIndexValue = alphabet.indexOf(base32EncodedString[count]);
    if (-1 === currentIndexValue) {
      if ('=' === base32EncodedString[count]) {
        let paddingCount = 0;
        for (count; count < base32EncodedString.length; count++) {
          if ('=' !== base32EncodedString[count]) {
            throw 'Invalid \'=\' in encoded string';
          } else {
            paddingCount++;
          }
        }

        switch (paddingCount) {
          case 6:
            returnArray = returnArray.slice(0, returnArray.length - 4);
            break;
          case 4:
            returnArray = returnArray.slice(0, returnArray.length - 3);
            break;
          case 3:
            returnArray = returnArray.slice(0, returnArray.length - 2);
            break;
          case 1:
            returnArray = returnArray.slice(0, returnArray.length - 1);
            break;
          default:
            throw 'Incorrect padding';
        }
      } else {
        throw 'base32EncodedString contains invalid characters or invalid padding.';
      }
    } else {
      if (bitsRemaining > 5) {
        mask = currentIndexValue << (bitsRemaining - 5);
        currentByte = currentByte | mask;
        bitsRemaining -= 5;
      } else {
        mask = currentIndexValue >> (5 - bitsRemaining);
        currentByte = currentByte | mask;
        returnArray[arrayIndex++] = currentByte;
        currentByte = currentIndexValue << (3 + bitsRemaining);
        bitsRemaining += 3;
      }
    }
  }

  return new Uint8Array(returnArray);
}
