import * as assert from 'assert';
import * as path from 'path';
import * as fs from 'fs';
import { promisify } from 'util';
import { getAllFilesInUtilsDirectoryCached } from './utils/testHelpers';

const readFileFs = promisify(fs.readFile);
const readFile = async function( fileName: string ): Promise<string> {
  return await readFileFs(fileName, {encoding: "utf8"});
}

let allFilesInUtilsDirectory;
let filesWithoutFunction = [
  'utils/colors.sh',
];

async function extractFunctionNameFromBashFile (fileName: string): Promise<string> {
  let contents = await readFile(fileName);
  let functionNameMatch = contents.match(/\nfunction ([-_a-zA-Z0-9]+)/);
  if ( ! functionNameMatch) {
    throw new Error(`Could not extract a function name from given file '${fileName}'`);
  }
  return functionNameMatch[1];
}

async function readFirstLineFromFile (fileName: string): Promise<string> {
  let contents = await readFile(fileName);
  let firstLineMatch = contents.match(/(.*)\n/);
  if ( ! firstLineMatch) {
    throw new Error(`Could not extract a first line from given file '${fileName}'`);
  }
  return firstLineMatch[1];
}

describe('All files in /utils folder:', function() {
  before('Read in /utils files', async function readFilesFromUtils() {
    allFilesInUtilsDirectory = await getAllFilesInUtilsDirectoryCached();
  });
  
  it('are ending with .sh', async function () {
    allFilesInUtilsDirectory.forEach( file => {
      let expectedFileExtension = '.sh';
      let actualFileExtension = path.extname(file);
      assert.strictEqual(actualFileExtension, expectedFileExtension, `File extension must be '${expectedFileExtension}', `
      + `but was '${actualFileExtension}' for file '${file}'`);
    });
  });
  
  it('contain a /bin/bash shebang line', async function () {
    await Promise.all(allFilesInUtilsDirectory.map( async file => {
      let expectedShebang = '#!/bin/bash';
      let firstLineInFile = await readFirstLineFromFile(file);
      assert.strictEqual(expectedShebang, firstLineInFile, `First line in file '${file}'`
      + ` was '${firstLineInFile}', should be '${expectedShebang}'`);
    }));
  });
  
  it('contain a function matching their file name', async function () {
    await Promise.all(allFilesInUtilsDirectory.map( async file => {
      if (filesWithoutFunction.includes(file)) return;
      let expectedFunctionName = path.basename(file, path.extname(file));
      let actualFunctionName = await extractFunctionNameFromBashFile(file);
      assert.strictEqual(expectedFunctionName, actualFunctionName, `The file '${file}' contains a function`
      + ` called '${actualFunctionName}', expected function called '${expectedFunctionName}'`);
    }));
  });
  
});

export default false;