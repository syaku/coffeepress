util = require "util"
path = require "path"
config = require "config"
{exec} = require "child_process"
fs = require "fs"
path = require "path"

assets =
  coffee: "assets/coffee/"
  js: "assets/js/"
  css: "assets/css"
  img: "assets/img/"
  less : "assets/less/"

readDir = (dir, callback) ->
  files = fs.readdirSync "#{dir}"
  for file in files
    filepath = path.join dir, file
    stat = fs.statSync filepath
    if stat.isDirectory()
      readDir filepath, callback
    else
      callback filepath

copyFiles = (from, to)->
  readDir from, (file)->
    relPath = path.relative from, file
    targetPath = path.resolve "#{to}", relPath
    dirName = path.dirname targetPath
    if !fs.existsSync dirName
      fs.mkdirSync dirName
    exec "cp #{file} #{targetPath}", (err, stdout, stderr)->
      throw err if err
      console.log stdout+stderr

task "assets", "Build for assets.", ->
  console.log "Copy image files."
  copyFiles assets.img, "#{config.dirs.public}/img/"

  console.log "Copy javascript files."
  copyFiles assets.js, "#{config.dirs.public}/js/"
  
  console.log "Copy css files."
  copyFiles assets.css, "#{config.dirs.public}/css/"

  console.log "Compile less files."
  readDir assets.less, (file)->
    if path.extname(file) != '.less' then return
    console.log path.extname(file)
    exec "lessc #{file} > #{config.dirs.public}/css/#{path.basename file, ".less"}.css", (err, stdout, stderr) ->
      throw err if err
      console.log stdout+stderr

  console.log "Compile coffee files."
  readDir assets.coffee, (file)->
    exec "coffee -cbo #{config.dirs.public}/js/ #{file}", (err, stdout, stderr) ->
      throw err if err
      console.log stdout+stderr

task "update", "Update articles.", ->
  exec "coffee coffeepress.coffee -u", (err, stdout, stderr)->
    throw err if err
    console.log stdout+stderr
    util.puts "Update articles... Done."

