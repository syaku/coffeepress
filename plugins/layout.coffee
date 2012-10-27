fs = require "fs"
path = require "path"
jade = require "jade"

class Layout
  constructor: (@site, @config)->
    @layoutIndex()
    for article in @site.articles
      @layoutArticle(article)

  layoutArticle:(article)->
    outDir = path.join @config.dirs.public, path.dirname article.filename
    outFile = path.join @config.dirs.public, article.filename

    if !fs.existsSync outDir
      fs.mkdir outDir
    fs.readFile "#{@config.dirs.template}/article.jade", (err, data) =>
      fn = jade.compile data, {filename:"#{@config.dirs.template}/layout.jade"}
      fs.writeFile outFile,
        fn {
          dateFormat: require "./dateformat"
          site:@site
          article: article
          config:@config
        }, (err) ->
        throw err if err

  layoutIndex: ->
    fs.readFile "#{@config.dirs.template}/index.jade", (err, data) =>
      fn = jade.compile data, {filename:"#{@config.dirs.template}/layout.jade"}
      fs.writeFile "#{@config.dirs.public}/index.html",
        fn {
          dateFormat: require "./dateformat"
          site:@site
          config:@config
        }, (err) ->
        throw err if err

module.exports = 
  layout: (site, config)->
    new Layout site, config
    console.log "Layout plugin... Done."
