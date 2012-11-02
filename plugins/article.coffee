fs = require "fs"
path = require "path"
_ = require "underscore"

class ArticlePlugin
  constructor: (@site, @config)->
    @readDir @site.articles, @config.dirs.data
    @site.articles.sort (a, b)->
      b.timestamp.getTime() - a.timestamp.getTime()
    @site.recent_posts = @site.articles[0..9]

  toArticle:(file, dir)->
    data = fs.readFileSync "#{file}", "utf8"
    {mtime} = fs.statSync "#{file}"
    array = data.split "\n"
    [title, content] = [array[0], array[1..].join("\n")]
    category = path.relative(@config.dirs.data, dir).replace '\\', '/'
    ext = path.extname(file)
    filename = "#{path.basename(file, ext)}.html"
    if category != ""
      filename = "#{category}/#{filename}"
    article = 
      title:title
      content:content
      filename:filename
      timestamp:mtime
      category: category
      ext: ext

  readDir:(articles, dir) ->
    files = fs.readdirSync "#{dir}"
    for file in files
      filepath = path.join dir, file
      stat = fs.statSync filepath
      if stat.isDirectory()
        @readDir articles, filepath
      else
        ext = path.extname filepath
        if (_.indexOf @config.ext.data, ext) >= 0
          articles.push @toArticle filepath, dir

module.exports = (site, config)->
  new ArticlePlugin(site, config)
  console.log "Article plugin... Done."
