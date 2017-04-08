"use strict"

var enzyme = require("enzyme")

exports.shallow = function(node) {
  return function(opts) {
    return enzyme.shallow(node, opts)
  }
}
