const path = require('path');
const { CleanWebpackPlugin } = require('clean-webpack-plugin');
const TerserPlugin = require("terser-webpack-plugin");
const MiniCssExtractPlugin = require("mini-css-extract-plugin");
const CssMinimizerPlugin = require("css-minimizer-webpack-plugin");
const CopyPlugin = require("copy-webpack-plugin");
const dotenv = require('dotenv');

dotenv.config();
const devMode = process.env.NODE_ENV !== 'production';

module.exports = {
    entry: './assets/js/application.js',
    output: {
        filename: 'application.js',
        path: path.resolve(__dirname, 'public/assets')
    },
    devtool: devMode ? "source-map" : "hidden-source-map",
    watchOptions: {
        aggregateTimeout: 300,
        ignored: /node_modules/,
    },
    optimization: {
        minimizer: [
            new TerserPlugin({
                cache: true,
                parallel: true,
                sourceMap: devMode
            }),
            new CssMinimizerPlugin()
        ]
    },
    resolve: {
        extensions: [".js"],
        modules: [
            path.resolve(__dirname, "scripts"),
            "node_modules"
        ]
    },
    module: {
        rules: [
            {
                test: /\.js$/,
                exclude: /node_modules/,
                use: {
                    loader: 'babel-loader',
                    options: {
                        presets: ['@babel/preset-env']
                    }
                }
            },
            {
                test: /\.woff(2)?(\?v=[0-9]\.[0-9]\.[0-9])?$/,
                loader: "url-loader?limit=10000&mimetype=application/font-woff"
            },
            {
                test: /\.(ttf|eot|svg)(\?v=[0-9]\.[0-9]\.[0-9])?$/,
                loader: "file-loader"
            },
            {
                test: /\.css$/,
                use: [MiniCssExtractPlugin.loader, "css-loader"],
            },
            {
                test: /\.scss$/,
                use: [
                    MiniCssExtractPlugin.loader,
                    'css-loader',
                    'sass-loader',
                ],
            },
            {
                test: /\.(png|jpg|jpeg|gif|svg)$/,
                use: 'url-loader?limit=25000'
            },
        ]
    },
    plugins: [
        new CleanWebpackPlugin(),
        new MiniCssExtractPlugin({
            filename: "[name].css",
            chunkFilename: "[id].css"
        }),
        new CopyPlugin({
            patterns: [
                { from: 'assets/images', to: '../images' },
                { from: 'assets/vendor', to: '../vendor' }
            ],
        }),
    ],
    performance: {
        hints: devMode ? "warning" : false,
        maxEntrypointSize: 512000,
        maxAssetSize: 512000
    }
};
