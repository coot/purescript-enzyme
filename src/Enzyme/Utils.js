"use strict"

var react = require("react")

exports.isInstanceOf = function(reactThis) {
  return function(reactClass) {
    return reactThis instanceof reactClass
  }
}

exports.isValidElement = function(a) {
  return react.isValidElement(a)
}
