import * as fs from 'fs';
import * as tmp from 'tmp';
import { returnAsArray, utilsDirectory } from './tsUtils';
import { promisify } from 'util';
import { spawn } from 'child_process';
import * as recursiveReaddir from 'recursive-readdir';
import * as path from 'path';
import { filter, sortBy } from 'lodash';
import * as assert from 'assert';

const copyFile = promisify(fs.copyFile);

const testUtilsDirectory = __dirname;
const testDirectory = path.join(testUtilsDirectory, './../');
const dummyEnvFile = path.join(testUtilsDirectory, '.env.dummy');

async function createTempDirectory (): Promise<string> {
  return new Promise(function(resolve, reject) {
    tmp.dir({ unsafeCleanup: true}, (err, path) => {
      if (err) return reject(err);
      resolve(path);
    });
  });
}

async function copyFilesIntoDirectory (targetDirectory: string, files: Array<fs.PathLike> | fs.PathLike): Promise<void> {
  await Promise.all(returnAsArray(files).map( async file => {
    let targetFileName = path.join(targetDirectory, path.basename(file));
    await copyFile(file, targetFileName);
  }));
}

async function createTempDirectoryWithFiles (files: Array<fs.PathLike> | fs.PathLike): Promise<string> {
  let tempDirectoy = await createTempDirectory();
  await copyFilesIntoDirectory(tempDirectoy, files);
  return tempDirectoy;
}

interface bashExecutionResult {
  stdout: string,
  stderr: string,
  exitCode: number,
}

async function executeCommandSequenceInBash (sequenceOfCommands: Array<string>): Promise<bashExecutionResult> {
  let fullCommand = sequenceOfCommands.join(';')
  let resultObject = {
    stdout: '',
    stderr: '',
    exitCode: 0,
  }
  return new Promise(function(resolve, reject) {
    const execution = spawn(fullCommand, {
      shell: '/bin/bash',
    });
    execution.stdout.on('data', (data) => {
      resultObject.stdout += data;
    });
    execution.stderr.on('data', (data) => {
      resultObject.stderr += data;
    });
    execution.on('close', (code) => {
      resultObject.exitCode = code;
      // Remove the last line breaks for increase readability
      resultObject.stderr = resultObject.stderr.replace(/\n$/, '');
      resultObject.stdout = resultObject.stdout.replace(/\n$/, '');
      resolve(resultObject);
    });
  });
}

function shellOutputMustNotContainErrors (executionResult: bashExecutionResult): void {
  assert.strictEqual(executionResult.stderr, '', 'There must be no output in stderr.');
  assert.strictEqual(executionResult.exitCode, 0, 'Exit code must be 0');
}

function shellOutputMustContainStdout (executionResult: bashExecutionResult, expectedOutput: string | RegExp) {
  let resultMatches = executionResult.stdout.match(expectedOutput);
  assert(!!resultMatches, `Expected to find the expression '${expectedOutput}' `
  + `in bash's stdout, which was '${executionResult.stdout}'`)
}

let bashCommands: { [name: string] : ((input?: string) => Promise<string> | string) } = {};

bashCommands.sourceFunction = async function(functionToSource: string): Promise<string> {
  let bashUtils = await getAllFilesInUtilsDirectoryCached();
  let matchingFiles: Array<string> = filter(bashUtils, (utilFile) => {
    return utilFile.match(functionToSource);
  }) as Array<string>;
  if (matchingFiles.length === 0) {
    throw new Error(`Tried to find a function called '${functionToSource}' but could not locate it.`);
  }
  // If there are multiple files containing the searched string, the one with the smallest length will be our hit.
  // Example: ['logSomething.sh', 'logSomethingAndExit.sh'] should return logSomething.sh
  let shortestFileName = sortBy(matchingFiles, (fileName) => {return fileName.length})[0];
  return 'source ' + path.resolve(shortestFileName);
}

bashCommands.setUtilsDirectoryVariable = () => { return `export BASH_UTILS_LOCATION=${path.resolve(utilsDirectory)}`}

async function getAllFilesInFolder (folderName: string): Promise<Array<string>> {
  return new Promise(function(resolve, reject) {
    recursiveReaddir(folderName, (err, files) => {
      if (err) return reject(err);
      resolve(files);
    });
  });
}

const getAllFilesInUtilsDirectoryCached: () => Promise<Array<string>> = (function myFunc() : () => Promise<Array<string>> {
  let listOfFiles;
  if (listOfFiles) return listOfFiles;
  return (async function getAllFilesInUtilsDirectory () {
    let listOfFiles = await getAllFilesInFolder(utilsDirectory);
    return listOfFiles;
  });
})();


export {
  createTempDirectory,
  copyFilesIntoDirectory,
  createTempDirectoryWithFiles,
  testDirectory,
  testUtilsDirectory,
  dummyEnvFile,
  shellOutputMustNotContainErrors,
  shellOutputMustContainStdout,
  executeCommandSequenceInBash,
  bashCommands,
  getAllFilesInUtilsDirectoryCached,
}