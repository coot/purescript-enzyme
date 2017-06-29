"use strict"

var enzyme = require("enzyme")

exports.getNode = function(wrp) {
  return function() {
    return wrp.getNode()
  }
}

exports.getNodes = function(wrp) {
  return function() {
    return wrp.getNodes()
  }
}

exports.ref = function(wrp) {
  return function(refname) {
    return function() {
      return wrp.ref(refname)
    }
  }
}

exports.instance_ = function(wrp) {
  return function() {
    return wrp.instance()
  }
}

exports.update = function(wrp) {
  return function() {
    return wrp.update()
  }
}

exports.rerender = function(wrp) {
  return function(props) {
    return function() {
      return wrp.rerender(props)
    }
  }
}

exports.rerenderWithContext = function(wrp) {
  return function(props) {
    return function(ctx) {
      return function() {
        return wrp.rerender(props, ctx)
      }
    }
  }
}

exports.setProps = function(wrp) {
  return function(props) {
    return function() {
      return wrp.setProps(props)
    }
  }
}

exports.setState = function(wrp) {
  return function(state) {
    return function() {
      return wrp.setState(state)
    }
  }
}

exports.setContext = function(wrp) {
  return function(ctx) {
    return function() {
      return wrp.setContext(ctx)
    }
  }
}

exports.containsNode = function(wrp) {
  return function(node) {
    return function() {
      return wrp.contains(node)
    }
  }
}

exports.containsNodes = function(wrp) {
  return function(nodes) {
    return function() {
      return wrp.contains(nodes)
    }
  }
}

exports.containsMatchingElement = function(wrp) {
  return function(node) {
    return function() {
      return wrp.containsMatchingElement(node)
    }
  }
}

exports.containsAllMatchingElements = function(wrp) {
  return function(nodes) {
    return function() {
      return wrp.containsAllMatchingElement(nodes)
    }
  }
}

exports.containsAnyMatchingElements = function(wrp) {
  return function(nodes) {
    return function() {
      return wrp.containsAnyMatchingElement(nodes)
    }
  }
}

exports.equals = function(wrp) {
  return function(node) {
    return function() {
      return wrp.equals(node)
    }
  }
}

exports.matchesElement = function(wrp) {
  return function(node) {
    return function() {
      return wrp.matchesElement(node)
    }
  }
}

exports.find = function(wrp) {
  return function(selector) {
    return function() {
      return wrp.find(selector)
    }
  }
}

exports.is = function(wrp) {
  return function(selector) {
    return function() {
      return wrp.is(selector)
    }
  }
}

exports.isEmptyRender = function(wrp) {
  return function() {
    return wrp.isEmptyRender()
  }
}

exports.filterWhere = function(wrp) {
  return function(predicate) {
    return function() {
      return wrp.filterWhere(predicate)
    }
  }
}

exports.filter = function(wrp) {
  return function(selector) {
    return function() {
      return wrp.filter(selector)
    }
  }
}

exports.not = function(wrp) {
  return function(selector) {
    return function() {
      return wrp.not(selector)
    }
  }
}

exports.text = function(wrp) {
  return function() {
    return wrp.text()
  }
}

exports.html = function(wrp) {
  return function() {
    return wrp.html()
  }
}

exports.unmount = function(wrp) {
  return function() {
    return wrp.unmount()
  }
}

exports.simulate = function(wrp) {
  return function(ev) {
    return function() {
      return wrp.simulate(ev)
    }
  }
}

exports.simulateWithArgs = function(wrp) {
  return function(ev) {
    return function(args) {
      return function() {
        var all = Array.prototype.concat([ev], args)
        return wrp.simulate.call(wrp, all)
      }
    }
  }
}

exports.props = function(wrp) {
  return function() {
    return wrp.props()
  }
}

exports.state = function(wrp) {
  return function(name) {
    return function() {
      return wrp.state(name)
    }
  }
}

exports.context = function(wrp) {
  return function(name) {
    return function() {
      return wrp.context(name)
    }
  }
}

exports.children = function(wrp) {
  return function() {
    return wrp.children()
  }
}

exports.childrenBySelector = function(wrp) {
  return function(selector) {
    return function() {
      return wrp.children(selector)
    }
  }
}

exports.childAt = function(wrp) {
  return function(idx) {
    return function() {
      return wrp.childAt(idx)
    }
  }
}

exports.parents = function(wrp) {
  return function(selector) {
    return function() {
      return wrp.parents(selector)
    }
  }
}

exports.parent = function(wrp) {
  return function(selector) {
    return function() {
      return wrp.parent(selector)
    }
  }
}

exports.closest = function(wrp) {
  return function(selector) {
    return function() {
      return function() {
        return wrp.closest(selector)
      }
    }
  }
}

exports.shallow = function(wrp) {
  return function(opts) {
    return function() {
      return wrp.shallow(opts)
    }
  }
}

exports.prop = function(wrp) {
  return function(propName) {
    return function() {
      return wrp.prop(propName)
    }
  }
}

exports.key = function(wrp) {
  return function() {
    return wrp.key()
  }
}

exports.type_ = function(wrp) {
  return function() {
    return wrp.type()
  }
}

exports.name = function(wrp) {
  return function() {
    return wrp.name()
  }
}

exports.hasClass = function(wrp) {
  return function(clsName) {
    return function() {
      return wrp.hasClass(clsName)
    }
  }
}

exports.map = function(wrp) {
  return function(fn) {
    return function() {
      return wrp.map(fn)
    }
  }
}

exports.reduce = function(wrp) {
  return function(fn) {
    return function(acu) {
      return function() {
        return wrp.reduce(fn, acu)
      }
    }
  }
}

exports.reduceRight = function(wrp) {
  return function(fn) {
    return function(acu) {
      return function() {
        return wrp.reduceRight(fn, acu)
      }
    }
  }
}

exports.slice = function(wrp) {
  return function(begin) {
    return function(end) {
      return function() {
        return wrp.slice(begin, end)
      }
    }
  }
}

exports.some = function(wrp) {
  return function(selector) {
    return function() {
      return wrp.some(selector)
    }
  }
}

exports.someWhere = function(wrp) {
  return function(fn) {
    return function() {
      return wrp.someWhere(fn)
    }
  }
}

exports.every = function(wrp) {
  return function(selector) {
    return function() {
      return wrp.every(selector)
    }
  }
}

exports.everyWhere = function(wrp) {
  return function(fn) {
    return function() {
      return wrp.everyWhere(fn)
    }
  }
}

exports.findWhere = function(wrp) {
  return function(fn) {
    return function() {
      return wrp.findWhere(fn)
    }
  }
}

exports.get = function(wrp) {
  return function(idx) {
    return function() {
      return wrp.get(idx)
    }
  }
}

exports.at = function(wrp) {
  return function(idx) {
    return function() {
      return wrp.at(idx)
    }
  }
}

exports.first = function(wrp) {
  return function(idx) {
    return function() {
      return wrp.first(idx)
    }
  }
}

exports.last = function(wrp) {
  return function(idx) {
    return function() {
      return wrp.last(idx)
    }
  }
}

exports.isEmpty = function(wrp) {
  return function() {
    return wrp.isEmpty()
  }
}

exports.exists = function(wrp) {
  return function() {
    return wrp.exists()
  }
}

exports.debug = function(wrp) {
  return function() {
    return wrp.debug()
  }
}

exports.dive = function(wrp) {
  return function(opts) {
    return function() {
      return wrp.dive(opts)
    }
  }
}
