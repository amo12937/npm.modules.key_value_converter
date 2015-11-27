"use strict"

module.exports = class KeyValueConverter extends require "amo.modules.base"
  constructor: (@_opener = "%", @_closer = @_opener, @_separator = ".") -> undefined

  convert: (src, dict, prefix = "") ->
    dest = src
    for k, v of dict
      if Object.prototype.toString.call(v)[8...-1] is "Object"
        dest = @convert dest, v, "#{prefix}#{k}#{@_separator}"
      else
        dest = dest.split("#{@_opener}#{prefix}#{k}#{@_closer}").join v
    return dest
