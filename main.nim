import asynchttpserver, asyncdispatch
import os

var server = newAsyncHttpServer()
var rootPath = getCurrentDir().joinPath("web")

proc cb(req: Request) {.async.} =
  let file = rootPath.joinPath(req.url.path[1.. -1])
  if fileExists(file) == true:
    var str = readFile(file)
    await req.respond(Http200, str)
  else :
    await req.respond(Http404, "<h1> 404 not found </h1>")

asyncCheck server.serve(Port(8080), cb)
runForever()