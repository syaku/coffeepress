util = require "util"
path = require "path"
config = require "config"
{exec} = require "child_process"
fs = require "fs"

assets =
  coffee: "assets/coffee/"
  image: "assets/img/"
  less : "assets/less/"

readDir = (dir, callback) ->
  files = fs.readdirSync "#{dir}"
  for file in files
    filepath = path.join dir, file
    stat = fs.statSync filepath
    if stat.isDirectory()
      @readDir filepath, callback
    else
      callback filepath

task "assets", "Build for assets.", ->
  # Copy Images.
  readDir assets.image, (image)->
    exec "cp #{image} #{config.dirs.public}/img/", (err, stdout, stderr)->
      throw err if err
      console.log stdout+stderr
      console.log "Copy Images... Done."

  # Compile less files.
  readDir assets.less, (file)->
    exec "lessc #{file} > #{config.dirs.public}/css/#{path.basename file, ".less"}.css", (err, stdout, stderr) ->
      throw err if err
      console.log stdout+stderr
      util.puts "Compile less files... Done."

  # Compile coffee files.
  readDir assets.coffee, (file)->
    exec "coffee -cbo #{config.dirs.public}/js/ #{file}", (err, stdout, stderr) ->
      throw err if err
      console.log stdout+stderr
      util.puts "Compile coffee files... Done."

task "update", "Update articles.", ->
  exec "coffee coffeepress.coffee -u", (err, stdout, stderr)->
    throw err if err
    console.log stdout+stderr
    util.puts "Update articles... Done."

