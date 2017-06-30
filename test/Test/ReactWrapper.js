"use strict"

var enzyme = require("enzyme")

exports.isReactWrapper = function(wrp) {
  return wrp instanceof enzyme.ReactWrapper
}

exports.isThrowing = function(do_) {
  return (function() {
    try {
      do_()
      return function() {return false}
    } catch (e) {
      return function() {return true}
    }
  })
}
