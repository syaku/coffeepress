fs = require "fs"
path = require "path"

toArticle = (file, dir)->
  data = fs.readFileSync "#{file}", "utf8"
  {mtime} = fs.statSync "#{file}"
  array = data.split "\n"
  [title, content] = [array[0], array[1..].join("\n")]
  dirname = path.relative(dir, path.dirname(file))
  filename = "#{path.join(dirname, path.basename(file, ".md"))}.html"
  article = {
    title:title
      ,content:content
      ,filename:filename
      ,timestamp:mtime
      ,category: path.dirname filename
  }

readDir = (articles, dir) ->
  files = fs.readdirSync "#{dir}"
  for file in files
    filepath = path.join dir, file
    stat = fs.statSync filepath
    if stat.isDirectory()
      readDir articles, filepath
    else
      if path.extname(filepath) == ".md"
        articles.push toArticle filepath, dir

module.exports = (site, config)->
  readDir site.articles, config.dirs.data
  site.articles.sort (a, b)->
    b.timestamp.getTime() - a.timestamp.getTime()
  site.recent_posts = site.articles[0..9]
  console.log "Article plugin... Done."
