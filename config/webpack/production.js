const webpack = require('webpack')
const environment = require('./environment')

const config = environment.toWebpackConfig()

config.devtool = 'hidden-source-map'
module.exports = config
