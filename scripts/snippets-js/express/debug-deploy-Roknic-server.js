#!/usr/bin/env node

// Milos Roknic catch any-route nodejs server!
// Use a WIDE NET first!
// This server uses var and other 'old' patterns, to run on old node.js versions.
// https://stackoverflow.com/questions/55113447/node-js-http-server-routing

// console.error('DEBUG: Reached imports');
var fs = require('fs');
var http = require('http');
var path = require('path');

function dlog(data) {
  // log to console and file.
  console.log(data);
  fs.appendFileSync(path.join(__dirname, 'out-log.txt'), String(data) + '\n');
}

dlog('\n' + '*'.repeat(40));
dlog('Started app at ' + new Date());

var PORT = 1212;

var requestListener = function (req, res) {
  dlog('*'.repeat(5));
  var msg = [
    'Deployment Version: 1',
    // https://stackoverflow.com/questions/4310535/how-to-convert-anything-to-a-string-safely-in-javascript
    'req: ' + String(req.url),
    'NodeJS Version: ' + process.versions.node,
  ].join(';\n');
  dlog(msg);
  res.writeHead(200, { 'Content-Type': 'text/plain' });
  res.end(msg);
};

var server = http.createServer(requestListener);
server.listen(PORT, () => {
  dlog('Serving from PORT: ' + PORT);
});

// To hit this server:
// curl http://localhost:1212/
