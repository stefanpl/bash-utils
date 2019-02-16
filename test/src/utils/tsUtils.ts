import * as path from 'path';

function returnAsArray(whateverYouGiveMe: any, allowUndefined: boolean = false): Array<any> {
  if (isArray(whateverYouGiveMe)) {
    return whateverYouGiveMe;
  }
  if (whateverYouGiveMe === undefined && ! allowUndefined) {
    throw new Error(`'undefined' has been passed, but not allowed via 'allowUndefined'.`);
  }
  return [whateverYouGiveMe];
}

function isArray(variable: any): boolean {
  return Array.isArray(variable);
}

const baseDirectory = path.join(__dirname, './../../../');
const utilsDirectory = path.join(baseDirectory, 'utils');

export {
  isArray,
  returnAsArray,
  baseDirectory,
  utilsDirectory,
}