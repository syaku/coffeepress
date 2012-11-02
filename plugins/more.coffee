module.exports = (site, config) ->
  for article in site.articles
    if article.content.match(/([\s\S]*)<!--\s*more\s*-->/m)
      article.summary = RegExp.$1
  
  console.log "More plugin... Done."
