"use strict"

var react = require("react")

exports.isInstanceOf = function(reactThis) {
  return function(reactClass) {
    return reactThis instanceof reactClass
  }
}

exports.isValidElement = function(a) {
  if (a._reactInternalInstance) {
    return react.isValidElement(a._reactInternalInstance._currentElement)
  }
  var keys = Object.keys(a).filter(function(key) {return key.startsWith("__reactInternalInstance")})
  if (keys.length) {
    /*
     * ReactWrapper.getNode returns an object which requires this pass
     */
    var key = keys[0]
    var inst = a[key]
    return react.isValidElement(inst._currentElement)
  }
  return react.isValidElement(a)
}
