define = require('amdefine')(module)

define([], ->
  (req, res) -> res.render("index", { title: "Express" })
)


