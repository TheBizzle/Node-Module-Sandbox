# requirejs = require("requirejs")

define = require('amdefine')(module)

#
# * GET home page.
# 
define([], ->
  (req, res) -> res.render("index", { title: "Express" })
)


