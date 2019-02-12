const path = require('path');
const cp = require('child_process');

module.exports = {
  entry: {
    tests: './test/src/testSuite.js',
  },
  output: {
    path: path.resolve(__dirname, 'test/dist'),
    filename: '[name].compiled.js'
  },
  plugins: [
    new PostCompile(() => {
      cp.exec('pm2 restart all');
    })
  ],
  target: 'node',
  devtool: "cheap-module-eval-source-map",
};