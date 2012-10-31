fs = require "fs"
path = require "path"
jade = require "jade"

mkdir = (dir)->
  if fs.existsSync dir
    return
  else
    if !fs.existsSync path.dirname dir
      mkdir(path.dirname dir)
    fs.mkdirSync dir

module.exports = 
  parse: (site, config)->
    site.categories = {}
    for article in site.articles
      if article.category? && article.category.length > 0
        category = article.category
      else
        category = 'uncategorized'
      while category != '.'
        if !site.categories[category]?
          site.categories[category] = []
        site.categories[category].push article
        category = path.dirname category

  layout: (site, config)->
    for category, articles of site.categories
      label = if config.categories.labels[category]? then config.categories.labels[category] else category

      data = fs.readFileSync "#{config.dirs.template}/index.jade", "utf-8"
      fn = jade.compile data, {filename:"#{config.dirs.template}/layout.jade"}
      
      dirname = path.join config.dirs.public, category
  
      mkdir(dirname)

      fs.writeFile "#{dirname}/index.html",
        fn {
          dateFormat: require "dateformat"
          title: label
          subtitle: 'Category'
          site: site
          items: articles
          currentPage: null
          config:config
        }, (err) =>
          throw err if err

