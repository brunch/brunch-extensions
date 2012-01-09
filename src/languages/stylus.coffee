stylus = require 'stylus'
{BaseLanguage} = require './base'

# NIB is an official stylus library of useful mixins etc.
# just like Compass.
try
  nib = require('nib')()
catch error
  null

class exports.StylusLanguage extends BaseLanguage
  compile: (file, callback) ->
    @readFile file, (error, data) =>
      return callback error if error?
      compiler = stylus(data)
        .set('compress', yes)
        .set('firebug', !!@config.stylus?.firebug)
        .include(@getRootPath 'app', 'styles')

      compiler.use nib if nib
      compiler.render callback
