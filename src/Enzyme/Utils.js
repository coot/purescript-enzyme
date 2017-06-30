"use strict"

exports.isInstanceOf = function(reactThis) {
  return function(reactClass) {
    return reactThis instanceof reactClass
  }
}
