import * as fs from 'fs';
import * as tmp from 'tmp';
import { returnAsArray } from './tsUtils';
import { promisify } from 'util';
import { spawn } from 'child_process';
import * as path from 'path';

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

async function executeCommandSequenceInBash (sequenceOfCommands: Array<string>): Promise<any> {
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
      resolve(resultObject);
    });
  });
}


export {
  createTempDirectory,
  copyFilesIntoDirectory,
  createTempDirectoryWithFiles,
  testDirectory,
  testUtilsDirectory,
  dummyEnvFile,
  executeCommandSequenceInBash,
}