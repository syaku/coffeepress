jade = require "./jade"
markdown = require "./markdown"
fs = require "fs"

module.exports = (site, config)->
  for article in site.articles
    if article.ext == ".md"
      article.content = markdown article.content
    else if article.ext == ".jade"
      article.content = jade article.content, config

  console.log "Convert plugin... Done."

