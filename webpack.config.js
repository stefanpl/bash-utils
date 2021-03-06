const path = require('path');

module.exports = {
  entry: {
    tests: './test/src/_testSuite.ts',
  },
  output: {
    path: path.resolve(__dirname, 'test/dist'),
    filename: '[name].compiled.js'
  },
  // Do not replace process.env['NODE_ENV'] at compile time!
  optimization: {
    nodeEnv: false
  },
  module: {
    rules: [
      {
        test: /\.tsx?$/,
        use: 'ts-loader',
        exclude: /node_modules/
      }
    ]
  },
  node: {
    __filename: true,
    __dirname: true,
  },
  resolve: {
    extensions: [ '.tsx', '.ts', '.js' ]
  },
  plugins: [
  ],
  target: 'node',
  devtool: "source-map",
};