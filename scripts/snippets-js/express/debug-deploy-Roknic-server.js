#!/usr/bin/env node

// Milos Roknic catch any-route nodejs server!
// Use a WIDE NET first!
// This server uses var and other 'old' patterns, to run on old node.js versions.
// https://stackoverflow.com/questions/55113447/node-js-http-server-routing

// console.error('DEBUG: Reached imports');
var fs = require('fs');
var http = require('http');
var path = require('path');

function flog(data) {
  // Log to 'file'.
  fs.appendFileSync(path.join(__dirname, 'out-log.txt'), String(data) + '\n');
}

function dlog(data) {
  // 'Double' log to console and file.
  console.log(data);
  flog(data);
}

dlog('\n' + '*'.repeat(40));
dlog('Started app at ' + new Date());

var PORT = 1212;

var requestListener = function (req, res) {
  dlog('*'.repeat(5));
  // throw Error('asd'); // TODO: See about errors?
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

server.on('error', (err) => {
  // TODO: Test this error handler
  console.error('Server error', err);
  // https://stackoverflow.com/questions/18391212/is-it-not-possible-to-stringify-an-error-using-json-stringify
  var strErr = JSON.stringify(err, Object.getOwnPropertyNames(err));
  flog('Server error:\n' + strErr + '\n');
});

// To hit this server:
// curl http://localhost:1212/
