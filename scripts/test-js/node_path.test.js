#!/usr/bin/env node

const { runs, runsq } = require('../lib-js/sh');
runs(`echo "\n\nNODE_PATH:\n$NODE_PATH\n\n"`);

runsq('sudo npm install -g glob', { dontLog: true });
const glob = require('glob');

// runs('sudo yarn global add lodash');
// const _ = require('lodash'); // Can't install lodash globally on yarn?!

// Test glob
(function listAllJsFilesFromCWD() {
  console.log(`Glob found these js files in ${process.cwd()}:`);
  glob('**/*.js', function (err, files) {
    if (err) throw err;
    console.log(files);
  });
})();
