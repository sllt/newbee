import asynchttpserver, asyncdispatch
import os

var server = newAsyncHttpServer()
var rootPath = getCurrentDir().joinPath("web")
proc cb(req: Request) {.async.} =
  echo req.hostname
  let uri = req.url.path[1.. -1]
  if uri == "":
    if fileExists(rootPath.joinPath("index.html")) == true and fileExists(rootPath.joinPath("default.html")) == true :
      var str = readFile(rootPath.joinPath("index.html"))
      await req.respond(Http200, str)
    else:
      var dir  = getCurrentDir().joinPath("web")
      await req.respond(Http200, "str")
  let file = rootPath.joinPath(uri)
  if fileExists(file) == true:
    var str = readFile(file)
    await req.respond(Http200, str)
  else :
    await req.respond(Http404, "<h1> 404 not found </h1>")

echo "server start on http://0.0.0.0:8080"
asyncCheck server.serve(Port(8080), cb)
runForever()