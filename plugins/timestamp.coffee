module.exports = (site, config)->
  for article in site.articles
    if article.content.match(/<!--\s*timestamp\s(.+?)\s*-->/)
      article.timestamp = new Date("#{RegExp.$1}#{config.timezone}")
  site.articles.sort (a, b)->
      b.timestamp.getTime() - a.timestamp.getTime()

