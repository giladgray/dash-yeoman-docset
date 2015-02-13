fs        = require 'fs'        # file loading
cheerio   = require 'cheerio'   # html parsing
Sequelize = require 'sequelize' # db building

# docset project variables
NAME = 'yeoman-generator.docset'
PATH = "#{NAME}/Contents/Resources/Documents"
URL  = 'http://yeoman.io/authoring/'

# HTML Guides, saved from http://handlebarsjs.com
Files = require './_files.coffee'

# Docset sections, populated by header tags when a file is parsed
# `{type: {name: path, ...}}`
docset =
  Guide: {}
  Section: {}
  Function: {}
  Class: {}
  Module: {}
  Mixin: {}

# Populate the given entry type with this element.
# Returns an iterator function that can be passed directly to $().each.
populateEntry = (file, type, level, register=true) -> ->
  $el   = $(@)
  title = $el.text().trim().replace /\(\w+\)\s/, ''
  if register
    docset[type][title] = "#{file}##{$el.attr('id')}"
  level ?= if $el.is('h2') then 1 else 0
  title = encodeURIComponent(title)
  # insert table of contents anchor before this element
  $el.before "<a name='//dash_ref/#{type}/#{title}/#{level}' class='dashAnchor'></a>\n"

# Parse each file and populate docset object.
for title, file of Files.Guide.files
  $ = cheerio.load fs.readFileSync("html/#{file}")
  # discover docset entries
  docset.Guide[title] = file
  $('h2').each populateEntry(file, 'Section', 0)
  $('h3').each populateEntry(file, 'Section', 0)
  # standardize page <title> and <h1> tags
  $('title').text(title)
  # unless $('h1').length
  #   $('body > *:first-child').prepend "<h1>#{title}</h1>"
  # write modified HTML to docset contents
  fs.writeFileSync "#{PATH}/#{file}", $.html()

for type, spec of Files
  continue if type is 'Guide'
  for title, file of spec.files
    $ = cheerio.load fs.readFileSync("html/#{file}")
    docset[type][title] = file
    $('.subsection-title').each populateEntry(file, 'Section', 1, false)
    $('h4').each populateEntry(file, 'Function', 0)
    $('title').text(title)
    fs.writeFileSync "#{PATH}/#{file}", $.html()

console.log 'Docset Configuration:'
console.log docset
console.log '\n'

# Create the database!
db = new Sequelize 'database', 'username', 'password',
  dialect: 'sqlite'
  storage: "#{NAME}/Contents/Resources/docSet.dsidx"

# Create the SearchIndex table, per http://kapeli.com/docsets
SearchIndex = db.define 'searchIndex',
  id:
    type: Sequelize.INTEGER
    autoIncrement: true
    primaryKey: true
  name: Sequelize.STRING
  type: Sequelize.STRING
  path: Sequelize.STRING
,
  freezeTableName: true
  timestamps: false

# Recreate the table and populate it from docset object
db.sync(force: true)
  .complete ->
    for type, data of docset
      for name, path of data
        SearchIndex.create {name, type, path}
        # id is auto-incremented because it is primary key
