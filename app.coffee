requirejs = require("requirejs")

requirejs.config({
  nodeRequire: require
})

requirejs ["express", "./routes/index", "./routes/user", "http", "path", "less-middleware"], (express, index, user, http, path, lessFunc) ->

  app = express()
  
  # all environments
  app.set("port", process.env.PORT or 3000)
  app.set("views", __dirname + "/views")
  app.set("view engine", "jade")
  app.use(express.favicon())
  app.use(express.logger("dev"))
  app.use(express.bodyParser())
  app.use(express.methodOverride())
  app.use(app.router)
  app.use(lessFunc(src: __dirname + "/public"))
  app.use(express.static(path.join(__dirname, "public")))
  
  # development only
  app.use(express.errorHandler()  if "development" is app.get("env"))
  app.get("/",      index)
  app.get("/users", user)

  http.createServer(app).listen(app.get("port"), ->
    console.log("Express server listening on port " + app.get("port"))
  )


