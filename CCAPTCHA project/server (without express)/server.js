var http = require("http");
var url = require("url");

function start(route, handle) {
  function onRequest(request, response) {
    var pathname = url.parse(request.url).pathname;
    console.log("Получен запрос  " + pathname);

    route(handle, pathname);

    response.writeHead(200, {"Content-Type": "text/plain"});
    response.write("kill yourself on the wall");
    response.end();
  }

  http.createServer(onRequest).listen(8535);
  console.log(" --- Сервер стартовал --- ");
}

exports.start = start;
