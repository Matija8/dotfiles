#!/usr/bin/env node

// Before running this script do:
// sudo npm i -g glob;
// sudo yarn global add lodash
const glob = require('glob');
// const _ = require('lodash'); // Can't install lodash globally on yarn?!

(function listAllJsFilesFromCWD() {
  glob('**/*.js', function (err, files) {
    if (err) throw err;
    console.log(files);
  });
})();
