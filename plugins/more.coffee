module.exports = (site, config) ->
  for article in site.articles
    array = article.content.split "<!-- more -->"
    
    if array.length > 1
      article.summary = array[0]
  
  console.log "More plugin... Done."
