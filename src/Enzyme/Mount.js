"use strict"

var mount = require("enzyme").mount

exports._mount = function(node) {
  return function(opts) {
    return function() {
      return mount(node, opts)
    }
  }
}
