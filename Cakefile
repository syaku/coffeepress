util = require "util"
path = require "path"
config = require "config"
{exec} = require "child_process"

assets = {
  coffee: [
    "assets/coffee/"
  ]
  ,image: [
  ]
  ,less : [
    "assets/less/application.less"
  ]
}

task "assets", "Build for assets.", ->
  # Copy Images.
  for image in assets.image
    exec "cp #{image} #{config.dirs.public}/img/", (err, stdout, stderr)->
      throw err if err
      console.log stdout+stderr
      console.log "Copy Images... Done."

  # Compile less files.
  for file in assets.less
    exec "lessc #{file} > #{config.dirs.public}/css/#{path.basename file, ".less"}.css", (err, stdout, stderr) ->
      throw err if err
      console.log stdout+stderr
      util.puts "Compile less files... Done."

  # Compile coffee files.
  for file in assets.coffee
    exec "coffee -cbo #{config.dirs.public}/js/ #{file}", (err, stdout, stderr) ->
      throw err if err
      console.log stdout+stderr
      util.puts "Compile coffee files... Done."

task "update", "Update articles.", ->
  exec "coffee coffeepress.coffee", (err, stdout, stderr)->
    throw err if err
    console.log stdout+stderr
    util.puts "Update articles... Done."

