import * as assert from 'assert';
import * as path from 'path';
import { createTempDirectoryWithFiles, dummyEnvFile, executeCommandSequenceInBash, bashCommands, shellOutputMustContainStdout, shellOutputMustNotContainErrors } from './utils/testHelpers';
import { utilsDirectory } from './utils/tsUtils';

describe('The exportVariablesFromFile function:', function() {
  
  it('exports variables to a subprocess', async function () {
  
    let tempDir = await createTempDirectoryWithFiles(dummyEnvFile);
    let shellOutput = await executeCommandSequenceInBash([
      await bashCommands.setUtilsDirectoryVariable(),
      await bashCommands.sourceFunction('exportVariablesFromFile'),
      `cd ${tempDir}`,
      'exportVariablesFromFile .env.dummy',
      '/bin/bash -c \'echo variable in new process is ${someVariable}\''
    ]);
    shellOutputMustNotContainErrors(shellOutput);
    shellOutputMustContainStdout(shellOutput, 'variable in new process is someValue');
  });

  
});

export default false;