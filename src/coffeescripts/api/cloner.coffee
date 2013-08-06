  $ = require('../api/jquery')

  # (Object[T]) => Object[T]
  module.exports = (o) -> $.extend(true, {}, o)
