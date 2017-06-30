"use strict"

var enzyme = require("enzyme")

exports.unsafeGetReactElement = function(wrp) {
  // getNode returns a wrapper, this is the way to access ReactElement from it
  return wrp._reactInternalInstance._currentElement
}

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
