url = require('url')
path = require 'path'
cheerio = require 'cheerio'
map = require 'through2-map'

gulp = require 'gulp'
download = require 'gulp-download'

Files = require './_files.coffee'

parse = (selector) -> map.obj (file) ->
  $ = cheerio.load(file.contents.toString())
  $('h2').each ->
    $el = $(@)
    $el.attr 'id', $el.text().replace(/\W+/g, '-')
  file.contents = new Buffer($.html(selector))
  return file

wrap = (title, css) ->
  if not Array.isArray(css) then css = [css]
  cssLinks = ("<link rel=\"stylesheet\" href=\"#{file}\">" for file in css)
  return map.obj (file) ->
    contents = """
    <html>
      <head>
        #{cssLinks.join('\n')}
      </head>
      <body>
        #{file.contents.toString()}
      </body>
    </html>
    """
    file.contents = new Buffer(contents)
    return file

for name, spec of Files
  downloads = []
  for filename, filepath of spec.files
    downloads.push { file: filepath, url: url.resolve(spec.url, filepath) }

  css = (if Array.isArray(spec.css) then spec.css else [spec.css]).map (path) ->
    url.resolve(spec.url, path)

  download(downloads)
    .pipe parse(spec.selector)
    .pipe wrap(filename, css.map (file) -> if /^http/.test(file) then file else path.basename(file))
    .pipe gulp.dest('html')

  download(css)
    .pipe gulp.dest('yeoman-generator.docset/Contents/Resources/Documents')

# TODO: no header IDs in Guides
