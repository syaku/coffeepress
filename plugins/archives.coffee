fs = require "fs"
jade = require "jade"

module.exports =
  parse: (site, config) ->
    archives = {}
    for article in site.articles
      year = article.timestamp.getFullYear()
      mon = article.timestamp.getMonth()+1
      mon = "0"+mon if mon < 10
      if archives["#{year}-#{mon}"]?
        archives["#{year}-#{mon}"].push(article)
      else
        archives["#{year}-#{mon}"] = []
        archives["#{year}-#{mon}"].push(article)

    site.archives = archives

  layout: (site, config)->
    for key, value of site.archives
      data = fs.readFileSync "#{config.dirs.template}/index.jade", "utf-8"
      fn = jade.compile data, {filename:"#{config.dirs.template}/layout.jade", pretty:true}
      fs.writeFile "#{config.dirs.public}/#{key}.html",
        fn {
          dateFormat: require "./dateformat"
          title: key
          subtitle: 'Archive'
          site: site
          items: site.archives[key]
          currentPage: null
          config:config
        }, (err) =>
          throw err if err

