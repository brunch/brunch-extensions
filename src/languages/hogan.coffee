hogan = require 'hogan.js'
{BaseLanguage} = require './base'

# Requires Hogan 1.0.4
#
# Example:
# $(@el).html(template.render name: "mdp", city: "SF")
class exports.HoganJsLanguage extends BaseLanguage
  compile: (file, callback) ->
    @readFile file, (error, data) =>
      return callback error if error?
      try
        content = hogan.compile data,
          asString: true
        callback null, "exports.render = function(data){ var t = new Hogan.Template(); t.r=#{content}; return t.render(data);}"
      catch error
        callback error
