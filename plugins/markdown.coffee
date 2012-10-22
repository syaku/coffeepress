{Markdown} = require "node-markdown"

module.exports = (site, config)->
  for article in site.articles
    article.content = Markdown article.content
  
  console.log "Markdown plugin... Done."
