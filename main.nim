import asynchttpserver, asyncdispatch

var server = newAsyncHttpServer()

proc cb(req: Request) {.async.} =
  let str = readFile(req.url.path[1.. -1])
  await req.respond(Http200, str)

asyncCheck server.serve(Port(8080), cb)
runForever()