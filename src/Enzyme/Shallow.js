"use strict"

var shallow = require("enzyme").shallow

exports._shallow = function(node) {
  return function(opts) {
    return shallow(node, opts)
  }
}
