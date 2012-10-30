fs = require "fs"
jade = require "jade"

module.exports = 
  parse:(site, config)->
    for article, index in site.articles
      if index > 0
        article.next =
          title: site.articles[index-1].title
          filename: site.articles[index-1].filename
      if index+1 < site.articles.length
        article.prev =
          title: site.articles[index+1].title
          filename: site.articles[index+1].filename

  layout:(site, config)->
    maxPages = Math.ceil(site.articles.length / 5)
    for current in [1..maxPages]
      data = fs.readFileSync "#{config.dirs.template}/index.jade"
      fn = jade.compile data, {filename:"#{config.dirs.template}/layout.jade"}
      fs.writeFile "#{config.dirs.public}/index#{if 1 < current then current else ""}.html",
        fn {
          dateFormat: require "./dateformat"
          site:site
          config:config
          title: config.title
          items: site.articles[5*(current-1)..5*(current-1)+4]
          currentPage: current
          pagination:[1..maxPages]
        }, (err) ->
          throw err if err

