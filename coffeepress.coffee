fs = require "fs"
path = require "path"
jade = require "jade"
config = require "config"
opts = require "opts"
_ = require "underscore"

class Blog
  constructor: (@config) ->
    @site = {
      title: config.title
      ,description: config.description
      ,url: config.url
      ,articles: []
    }

  generate: =>
    plugins = []
    for pluginFile in @config.plugins
      plugins.push require("#{@config.dirs.plugins}/#{pluginFile}")

    # parse
    for plugin in plugins
      if _.isFunction plugin
        plugin @site, @config
      else if plugin.parse?
        plugin.parse @site, @config

    # layout
    for plugin in plugins
      if plugin.layout?
        plugin.layout @site, @config

blog = new Blog(config)

options = [
  {
    short : "w"
    ,long : "watch"
    ,description : "Watch data directory."
    ,callback: ->
      console.log "Begin watching."
      fs.watch config.dirs.data, (event, file) ->
        console.log "Change data directory."
        blog.generate()
  }
  ,{
    short: "u"
    ,long: "update"
    ,description : "Update articles."
    ,callback: ->
      console.log "Update articles..."
      blog.generate()
      console.log "Done."
  }
]

opts.parse(options, true)
