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

exports.getDOMNode = function(wrp) {
  return function() {
    return wrp.getDOMNode()
  }
}

exports.ref = function(refname) {
  return function(wrp) {
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

exports.unmount = function(wrp) {
  return function() {
    return wrp.unmount()
  }
}

exports.mount = function(wrp) {
  return function() {
    return wrp.mount()
  }
}

exports.setProps = function(props) {
  return function(wrp) {
    return function() {
      return wrp.setProps(props)
    }
  }
}

exports.setState = function(state) {
  return function(wrp) {
    return function() {
      return wrp.setState(state)
    }
  }
}

exports.setContext = function(ctx) {
  return function(wrp) {
    return function() {
      return wrp.setContext(ctx)
    }
  }
}

exports.matchesElement = function(node) {
  return function(wrp) {
    return function() {
      return wrp.matchesElement(node)
    }
  }
}

exports.containsNode = function(node) {
  return function(wrp) {
    return function() {
      return wrp.contains(node)
    }
  }
}

exports.containsNodes = function(nodes) {
  return function(wrp) {
    return function() {
      return wrp.contains(nodes)
    }
  }
}

exports.containsMatchingElement = function(node) {
  return function(wrp) {
    return function() {
      return wrp.containsMatchingElement(node)
    }
  }
}

exports.containsAllMatchingElements = function(nodes) {
  return function(wrp) {
    return function() {
      return wrp.containsAllMatchingElement(nodes)
    }
  }
}

exports.containsAnyMatchingElements = function(nodes) {
  return function(wrp) {
    return function() {
      return wrp.containsAnyMatchingElement(nodes)
    }
  }
}

exports.find = function(selector) {
  return function(wrp) {
    return function() {
      return wrp.find(selector)
    }
  }
}

exports.is = function(selector) {
  return function(wrp) {
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

exports.filterWhere = function(predicate) {
  return function(wrp) {
    return function() {
      return wrp.filterWhere(predicate)
    }
  }
}

exports.filter = function(selector) {
  return function(wrp) {
    return function() {
      return wrp.filter(selector)
    }
  }
}

exports.not = function(selector) {
  return function(wrp) {
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

exports.simulate = function(ev) {
  return function(wrp) {
    return function() {
      return wrp.simulate(ev)
    }
  }
}

exports.simulateAndMock = function(ev) {
  return function(mock) {
    return function(wrp) {
      return function() {
        return wrp.simulateAndMock(ev, mock)
      }
    }
  }
}

exports.props = function(wrp) {
  return function() {
    return wrp.props()
  }
}

exports.state = function(name) {
  return function(wrp) {
    return function() {
      return wrp.state(name)
    }
  }
}

exports.context = function(name) {
  return function(wrp) {
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

exports.childrenBySelector = function(selector) {
  return function(wrp) {
    return function() {
      return wrp.children(selector)
    }
  }
}

exports.childAt = function(idx) {
  return function(wrp) {
    return function() {
      return wrp.childAt(idx)
    }
  }
}

exports.parents = function(wrp) {
  return function() {
    return wrp.parents()
  }
}


exports.parentsBySelector = function(selector) {
  return function(wrp) {
    return function() {
      return wrp.parents(selector)
    }
  }
}

exports.parent = function(wrp) {
  return function() {
    return wrp.parent(selector)
  }
}

exports.closest = function(selector) {
  return function(wrp) {
    return function() {
      return wrp.closest(selector)
    }
  }
}

exports.prop = function(propName) {
  return function(wrp) {
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

exports.typeImpl = function(wrp) {
  return function() {
    return wrp.type()
  }
}

exports.name = function(wrp) {
  return function() {
    return wrp.name()
  }
}

exports.hasClass = function(clsName) {
  return function(wrp) {
    return function() {
      return wrp.hasClass(clsName)
    }
  }
}

exports.map = function(fn) {
  return function(wrp) {
    return function() {
      return wrp.map(fn)
    }
  }
}

exports.reduce = function(fn) {
  return function(acu) {
    return function(wrp) {
      return function() {
        return wrp.reduce(fn, acu)
      }
    }
  }
}

exports.reduceRight = function(fn) {
  return function(acu) {
    return function(wrp) {
      return function() {
        return wrp.reduceRight(fn, acu)
      }
    }
  }
}

exports.slice = function(begin) {
  return function(end) {
    return function(wrp) {
      return function() {
        return wrp.slice(begin, end)
      }
    }
  }
}

exports.some = function(selector) {
  return function(wrp) {
    return function() {
      return wrp.some(selector)
    }
  }
}

exports.someWhere = function(fn) {
  return function(wrp) {
    return function() {
      return wrp.someWhere(fn)
    }
  }
}

exports.every = function(selector) {
  return function(wrp) {
    return function() {
      return wrp.every(selector)
    }
  }
}

exports.everyWhere = function(fn) {
  return function(wrp) {
    return function() {
      return wrp.everyWhere(fn)
    }
  }
}

exports.get = function(idx) {
  return function(wrp) {
    return function() {
      return wrp.get(idx)
    }
  }
}

exports.at = function(idx) {
  return function(wrp) {
    return function() {
      return wrp.at(idx)
    }
  }
}

exports.first = function(wrp) {
  return function() {
    return wrp.first()
  }
}

exports.last = function(wrp) {
  return function() {
    return wrp.last()
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

exports.detach = function(wrp) {
  return function() {
    wrp.detach()
  }
}
