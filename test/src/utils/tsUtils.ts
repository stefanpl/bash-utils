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

export {
  isArray,
  returnAsArray,
}