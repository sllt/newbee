import asynchttpserver, asyncdispatch
import os

var server = newAsyncHttpServer()

proc cb(req: Request) {.async.} =
  let file = req.url.path[1.. -1]
  if fileExists(file) == true:
    var str = readFile(file)
    await req.respond(Http200, str)
  else :
    await req.respond(Http200, "<h1> 404 not found </h1>")

asyncCheck server.serve(Port(8080), cb)
runForever()