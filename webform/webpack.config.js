var webpack = require('webpack');
var path = require('path');
var fs = require('fs');
var CleanWebpackPlugin = require('clean-webpack-plugin');
var CopyWebpackPlugin = require('copy-webpack-plugin');
var ExtractTextPlugin = require("extract-text-webpack-plugin");
var CompressionPlugin = require("compression-webpack-plugin");
var webqManifest = require('./manifest.config.js');
var yazl = require('yazl');

module.exports = function (env = {}) {
  return {
    context: __dirname,
    entry: {
      app: ['./js/app.js'],
    },
    output: {
      path: __dirname + '/dist',
      filename: 'app.js'
    },
    module: {
      loaders: [
        {
          test: /\.woff(2)?(\?[a-z0-9]+)?$/,
          loader: "url-loader?limit=10000&mimetype=application/font-woff"
        }, {
          test: /\.(ttf|eot|svg)(\?[a-z0-9]+)?$/,
          loader: "file-loader"
        },
        {
          test: /\.(png)$/,
          loader: 'file-loader',
        },
      ],
      rules: [
      {
        test: /\.css$/,
        use: ExtractTextPlugin.extract({
          use: [{
            loader: "css-loader",
            options: { url: false, minimize: true }
          }]
        })
      }
    ]
    },
    devServer: {
      contentBase: './dist'
    },
    plugins: [
      new CleanWebpackPlugin(['dist'], {
        root: __dirname,
        verbose: true,
        dry: false,
      }),
      new webpack.optimize.UglifyJsPlugin({
        sourceMap: true,
        ie8: true,
        mangle: false,
      }),
      new ExtractTextPlugin("app.css"),
      new CopyWebpackPlugin([
        { from:'./css', ignore: ['*.css'] },
        { from:'./img', ignore: ['*.db'] },
        //{ from:'./js' },
        { from: './index.html' },
        { from: './../instance', ignore: ['*test*'] },
        { from: './../translations/mmr-pams-labels-en.json' },
        { from: './../schema/NEC_PAMs.xsd' },
      ]),
      // new CompressionPlugin({
      //   asset: "[path].gz[query]",
      //   algorithm: "gzip",
      //   test: /\.js$|\.json$|\.css$|\.html$/,
      //   threshold: 10240,
      //   minRatio: 0.4
      // }),
      //Extract file info, create webq manifest file and make a zip-file out of it
      function() {
        this.plugin("done", function(statsData) {
          if (env.build === "production" || env.build === "development") {
            var stats = statsData.toJson();
            if (!stats.errors.length) {
              var zipfile = new yazl.ZipFile();
              var manifest = { projectFiles: [] };
              manifest.projectFiles.push(webqManifest[env.build]);
              Object.keys(stats.assets).forEach(key => {
                if (stats.assets[key].name !== "index.html") {
                  manifest.projectFiles.push({
                    title: stats.assets[key].name,
                    file: {
                      name: stats.assets[key].name
                    },
                    fileType: "FILE"
                  });
                }
                zipfile.addFile(path.join(__dirname, 'dist', stats.assets[key].name), stats.assets[key].name);
              });
              fs.writeFileSync(path.join(__dirname, 'dist', 'webform-project-export.metadata'), JSON.stringify(manifest));
              zipfile.addFile(path.join(__dirname, 'dist', 'webform-project-export.metadata'), 'webform-project-export.metadata');
              zipfile.outputStream.pipe(fs.createWriteStream('dist/webq-deploy.zip'));
              zipfile.end();
            }
          }
        });
      }
    ]
  }
};