"use strict"

var react = require("react")
var enzyme = require("enzyme")

exports.isValidElement = function(a) {
  return react.isValidElement(a)
}

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
      console.log(e.message)
      return function() {return true}
    }
  })
}
