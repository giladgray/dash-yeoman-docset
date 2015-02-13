# Dash Yeoman Generator Docset

> [Yeoman Generator](http://yeoman.io/authoring/) docset for the excellent Dash documentation browser.

Yeoman Generator is a fully featured promise library with focus on innovative features and performance. Its documentation is good and thorough but available only as a massive markdown file on GitHub. Not anymore!

## Installation
This docset will be available as a user-contributed Dash docset.

You can add it to Dash yourself by cloning and building via the instructions below, or by downloading a release archive from the Releases page.

## Development
Building this docset yourself is simple:

1. `npm install -g coffee-script` (if you haven't already)
2. `git clone` this repo
3. `npm install`
4. `coffee fetch.coffee` to download and process raw HTML files
4. `coffee docset.coffee` to rebuild the Sqlite database
5. `npm run tar` to generate `yeoman-generator.tgz` archive
6. `npm run dash` to copy necessary files to `../Dash-User-Contributions` repo
7. submit PR!

*How did you modify the original documentation?*

Other Dash Docset files can be found in the `yeoman-generator.docset` folder, such as `icon.png`, `Contents/Info.plist`, and `Contents/Resources/docSet.dsidx`.

The `docset.coffee` script parses the HTML file to find Section and Function headers and generates the `searchIndex` database table. It also injects table-of-contents anchors to the HTML files and writes them to `yeoman-generator.docset/Contents/Resources/Documents`.
