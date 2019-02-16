import * as assert from 'assert';
import { bashCommands } from './utils/testHelpers';
import * as path from 'path';
import { utilsDirectory } from './utils/tsUtils';

describe('Test helper functions:', function() {
  
  it('bashCommands.sourceFunction produces correct output', async function () {
    let returnedSourceStatement = await bashCommands.sourceFunction('loadNvm');
    let actualPath = path.resolve(path.join(utilsDirectory, 'loadNvm.sh'));
    assert(path.isAbsolute(actualPath), 'The returned path should be absolute.');
    let expectedSourceStatement = `source ${actualPath}`;
    assert.strictEqual(returnedSourceStatement, expectedSourceStatement);
  });
  
});

export default false;