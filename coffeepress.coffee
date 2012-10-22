fs = require "fs"
path = require "path"
jade = require "jade"
config = require "config"
opts = require "opts"

class Blog
  constructor: (@config) ->
    @site = {
      title: config.title
      ,description: config.description
      ,url: config.url
      ,articles: []
    }

  generate: =>
    for pluginFile in @config.plugins
      plugin = require "#{@config.dirs.plugins}/#{pluginFile}"
      plugin @site, @config

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
