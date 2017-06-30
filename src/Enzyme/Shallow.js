"use strict"

var shallow = require("enzyme").shallow

exports._shallow = function(node) {
  return function(opts) {
    return function() {
      return shallow(node, opts)
    }
  }
}
