jade = require "jade"
fs = require "fs"
path = require "path"
dateFormat = require "dateformat"

module.exports = (site, config)->
  items = []
  for article in site.articles
    now = new Date()
    items.push {
      title: article.title
      ,filename: article.filename
      ,description: article.content
      ,pubdate: dateFormat(article.timestamp, "ddd, dd mmm yyyy HH:MM:ss +0900")
    }

  data = fs.readFileSync "#{config.dirs.template}/feed.jade", "utf-8"
  fn = jade.compile data, {filename:"#{config.dirs.template}/feed.jade", pretty:true}
  fs.writeFile "#{config.dirs.public}/feed.rss",
    fn {
      site:site
      , items:items
      , config:config
    }, (err) =>
      throw err if err
  console.log "Feed plugin... Done."
