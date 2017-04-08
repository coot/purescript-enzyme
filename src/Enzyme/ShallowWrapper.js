"use strict"

var enzyme = require("enzyme")

exports.getNode = function(wrp) {
  return wrp.getNode()
}

exports.getNodes = function(wrp) {
  return wrp.getNodes()
}

exports.getDOMNode = function(wrp) {
  return wrp.getDOMNode()
}

exports.ref = function(wrp) {
  return function(refname) {
    return wrp.ref(refname)
  }
}

exports.instance_ = function(wrp) {
  return wrp.instance()
}

exports.update = function(wrp) {
  return function() {
    return wrp.update()
  }
}

exports.rerender = function(wrp) {
  return function(props) {
    return wrp.rerender(props, ctx)
  }
}

exports.rerenderWithContext = function(wrp) {
  return function(props) {
    return function(ctx) {
      return wrp.rerender(props, ctx)
    }
  }
}

exports.setProps = function(wrp) {
  return function(props) {
    return wrp.setProps(props)
  }
}

exports.setState = function(wrp) {
  return function(state) {
    return wrp.setState(state)
  }
}

exports.setContext = function(wrp) {
  return function(ctx) {
    return wrp.setContext(ctx)
  }
}

exports.containsNode = function(wrp) {
  return function(node) {
    return wrp.contains(node)
  }
}

exports.containsNodes = function(wrp) {
  return function(nodes) {
    return wrp.contains(nodes)
  }
}

exports.containsMatchingElement = function(wrp) {
  return function(node) {
    return wrp.containsMatchingElement(node)
  }
}

exports.containsMatchingElements = function(wrp) {
  return function(nodes) {
    return wrp.containsMatchingElements(nodes)
  }
}

exports.containsAllMatchingElements = function(wrp) {
  return function(nodes) {
    return wrp.containsAllMatchingElement(nodes)
  }
}

exports.containsAnyMatchingElements = function(wrp) {
  return function(nodes) {
    return wrp.containsAnyMatchingElement(nodes)
  }
}

exports.equals = function(wrp) {
  return function(node) {
    return wrp.equals(node)
  }
}

exports.matchesElement = function(wrp) {
  return function(node) {
    return wrp.matchesElement(node)
  }
}

exports.find = function(wrp) {
  return function(selector) {
    return wrp.find(selector)
  }
}

exports.is = function(wrp) {
  return function(selector) {
    return wrp.is(selector)
  }
}

exports.isEmptyRender = function(wrp) {
  return wrp.isEmptyRender()
}

exports.filterWhere = function(wrp) {
  return function(predicate) {
    return wrp.filterWhere(predicate)
  }
}

exports.filter = function(wrp) {
  return function(selector) {
    return wrp.filter(selector)
  }
}

exports.not = function(wrp) {
  return function(selector) {
    return wrp.not(selector)
  }
}

exports.text = function(wrp) {
  return wrp.text()
}

exports.html = function(wrp) {
  return wrp.html()
}

exports.unmount = function(wrp) {
  return wrp.unmount()
}

exports.simulate = function(wrp) {
  return function(ev) {
    return wrp.simulate(ev)
  }
}

exports.simulateWithArgs = function(wrp) {
  return function(ev) {
    return function(args) {
      var all = Array.prototype.concat([ev], args)
      return wrp.simulate.call(wrp, all)
    }
  }
}

exports.props = function(wrp) {
  return wrp.props()
}

exports.state = function(wrp) {
  return function(name) {
    return wrp.state(name)
  }
}

exports.context = function(wrp) {
  return function(name) {
    return wrp.context(name)
  }
}

exports.children = function(wrp) {
  return function(selector) {
    return wrp.children(selector)
  }
}

exports.childAt = function(wrp) {
  return function(idx) {
    return wrp.childAt(idx)
  }
}

exports.parents = function(wrp) {
  return function(selector) {
    return wrp.parents(selector)
  }
}

exports.parent = function(wrp) {
  return function(selector) {
    return wrp.parent(selector)
  }
}

exports.closest = function(wrp) {
  return function(selector) {
    return wrp.closest(selector)
  }
}

exports.shallow = function(wrp) {
  return function(opts) {
    return wrp.shallow(opts)
  }
}

exports.prop = function(wrp) {
  return function(propName) {
    return wrp.prop(propName)
  }
}

exports.key = function(wrp) {
  return wrp.key()
}

exports.type_ = function(wrp) {
  return wrp.type()
}

exports.name = function(wrp) {
  return wrp.name()
}

exports.hasClass = function(wrp) {
  return function(clsName) {
    return wrp.hasClass(clsName)
  }
}

exports.map = function(wrp) {
  return function(fn) {
    return wrp.map(fn)
  }
}

exports.reduce = function(wrp) {
  return function(fn) {
    return function(acu) {
      return wrp.reduce(fn, acu)
    }
  }
}

exports.reduceRight = function(wrp) {
  return function(fn) {
    return function(acu) {
      return wrp.reduceRight(fn, acu)
    }
  }
}

exports.slice = function(wrp) {
  return function(begin) {
    return function(end) {
      return wrp.slice(begin, end)
    }
  }
}

exports.some = function(wrp) {
  return function(selector) {
    return wrp.some(selector)
  }
}

exports.someWhere = function(wrp) {
  return function(fn) {
    return wrp.someWhere(fn)
  }
}

exports.every = function(wrp) {
  return function(selector) {
    return wrp.every(selector)
  }
}

exports.everyWhere = function(wrp) {
  return function(fn) {
    return wrp.everyWhere(fn)
  }
}

exports.findWhere = function(wrp) {
  return function(fn) {
    return wrp.findWhere(fn)
  }
}

exports.get = function(wrp) {
  return function(idx) {
    return wrp.get(idx)
  }
}

exports.at = function(wrp) {
  return function(idx) {
    return wrp.at(idx)
  }
}

exports.first = function(wrp) {
  return function(idx) {
    return wrp.first(idx)
  }
}

exports.last = function(wrp) {
  return function(idx) {
    return wrp.last(idx)
  }
}

exports.isEmpty = function(wrp) {
  return wrp.isEmpty()
}

exports.exists = function(wrp) {
  return wrp.exists()
}

exports.debug = function(wrp) {
  return wrp.debug()
}

exports.dive = function(wrp) {
  return function(opts) {
    return wrp.dive(opts)
  }
}

exports.detach = function(wrp) {
  return function() {
    wrp.detach()
  }
}
