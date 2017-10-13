var merge = require('webpack-merge')
var prodEnv = require('./prod.env')

module.exports = merge(prodEnv, {
  NODE_ENV: '"development"',
  RAILS_SERV_BASE: "'http://localhost:3000'",
  GMAP_KEY: "'AIzaSyBtLi9R9sjyWzMyggNDWqPhivN42PJIF3s'"
})
