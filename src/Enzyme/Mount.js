"use strict"

var enzyme = require("enzyme")

exports.mount = function(node) {
  return function(opts) {
    return enzyme.mount(node, opts)
  }
}
