const webpack = require('webpack')
const environment = require('./environment')

const config = environment.toWebpackConfig()

config.devtool = 'cheap-eval-source-map'
module.exports = config
