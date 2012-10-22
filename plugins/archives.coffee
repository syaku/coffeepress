fs = require "fs"
jade = require "jade"

module.exports = (site, config) ->
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

  for key, value of archives
    data = fs.readFileSync "#{config.dirs.template}/archives.jade", "utf-8"
    fn = jade.compile data, {filename:"#{config.dirs.template}/layout.jade"}
    fs.writeFile "#{config.dirs.public}/#{key}.html",
      fn {
        title: key
        site: site
        ,key: key
        , config:config
      }, (err) =>
        throw err if err

  console.log "Archives plugin... Done."
