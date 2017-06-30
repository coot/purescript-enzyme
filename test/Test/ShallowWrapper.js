"use strict"

var enzyme = require("enzyme")

exports.isShallowWrapper = function(wrp) {
  return wrp instanceof enzyme.ShallowWrapper
}
