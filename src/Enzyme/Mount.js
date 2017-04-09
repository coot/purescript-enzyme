"use strict"

var mount = require("enzyme").mount

exports._mount = function(node) {
  return function(opts) {
    return mount(node, opts)
  }
}
