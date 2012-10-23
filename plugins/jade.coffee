jade = require "jade"
fs = require "fs"

module.exports = (content)->
  fn = jade.compile content
  return fn {}, (err)->throw err if err
