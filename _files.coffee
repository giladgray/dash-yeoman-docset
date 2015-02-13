url = require 'url'

apiLink = ($el) ->
  if $el.attr('href').match /\.js\.html/
    $el.attr 'href', url.resolve @url, $el.attr('href')

guideLink = ($el) ->
  href = $el.attr('href').replace('/authoring/', '')
  if /^\//.test href
    href = url.resolve @url, href
  $el.attr('href', href)

module.exports =
  Guide:
    url: 'http://yeoman.io/authoring/'
    css: [
      '/assets/css/main.3009.css'
      'http://fonts.googleapis.com/css?family=Roboto+Slab:400,700|Roboto:400,700,700italic,400italic'
    ]
    files: {
      'Getting started'                  : 'index.html'
      'Running Context'                  : 'running-context.html'
      'User Interactions'                : 'user-interactions.html'
      'Composability'                    : 'composability.html'
      'Managing Dependencies'            : 'dependencies.html'
      'Interacting with the file system' : 'file-system.html'
      'Creating a Gruntfile'             : 'gruntfile.html'
      'Storing user configs'             : 'storage.html'
      'Unit testing'                     : 'testing.html'
    }
    contentSelector: '.page-title, article.main'
    sectionSelectors:
      h2: 'Section'
      h3: 'Function'
    processLink: guideLink

  Module:
    url: 'http://yeoman.github.io/generator/'
    css: ['styles/prettify-tomorrow.css', 'styles/jsdoc-default.css']
    files: {
      'test/assert'      : 'assert.html'
      'test/helpers'     : 'helpers.html'
      'yeoman-generator' : 'module-yeoman-generator.html'
    }
    contentSelector: '.page-title, section > article'
    sectionSelectors:
      h3: 'Section'
      h4: 'Function'
    processLink: apiLink

  Class:
    url: 'http://yeoman.github.io/generator/'
    css: ['styles/prettify-tomorrow.css', 'styles/jsdoc-default.css']
    files: {
      'Base'            : 'Base.html'
      'Environment'     : 'Environment.html'
      'NamedBase'       : 'NamedBase.html'
      'RunContext'      : 'RunContext.html'
      'Storage'         : 'Storage.html'
      'TerminalAdapter' : 'TerminalAdapter.html'
    }
    contentSelector: '.page-title, section > article'
    sectionSelectors:
      h3: 'Section'
      h4: 'Function'
    processLink: apiLink

  Mixin:
    url: 'http://yeoman.github.io/generator/'
    css: ['styles/prettify-tomorrow.css', 'styles/jsdoc-default.css']
    files: {
      'actions/actions'       : 'actions.html'
      'actions/fetch'         : 'fetch.html'
      'actions/file'          : 'file.html'
      'actions/help'          : 'help.html'
      'actions/install'       : 'install.html'
      'actions/invoke'        : 'invoke.html'
      'actions/remote'        : 'remote.html'
      'actions/spawn_command' : 'spawn_command.html'
      'actions/string'        : 'string.html'
      'actions/user'          : 'user.html'
      'actions/wiring'        : 'wiring.html'
      'env/resolver'          : 'resolver.html'
      'util/common'           : 'common.html'
    }
    contentSelector: '.page-title, section > article'
    sectionSelectors:
      h3: 'Section'
      h4: 'Function'
    processLink: apiLink
