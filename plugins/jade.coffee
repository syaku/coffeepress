jade = require "jade"
fs = require "fs"

module.exports = (content, config)->
  fn = jade.compile content
  return fn {config:config}, (err)->throw err if err
