const path = require('path')
const webpack = require('webpack')
const MiniCssExtractPlugin = require('mini-css-extract-plugin')

module.exports = {
  mode: 'production',
  entry: path.resolve(__dirname, 'app/javascript/packs'),
  plugins: [new MiniCssExtractPlugin()],
  module: {
    rules: [
      {
        test: /\.coffee$/,
        use: [ 'coffee-loader' ]
      },
      {
        test: /\.css$/,
        exclude: /node_modules/,
        use: [
          {
            loader: MiniCssExtractPlugin.loader,
            options: {}
          },
          {
            loader: 'css-loader',
            options: {
              importLoaders: 1,
            }
          },
          {
            loader: 'postcss-loader'
          }
        ]
      }
    ]
  },
  output: {
    library: '@tomasc/stripe-elements',
    libraryTarget: 'umd',
    path: path.resolve(__dirname, 'package')
  },
  watchOptions: {
    ignored: [/node_modules/, /\.css\.json/]
  }
};
