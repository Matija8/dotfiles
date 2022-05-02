#!/usr/bin/env node

const execSync = (() => {
  const execSync = require('child_process').execSync;
  return (command) => execSync(command, { encoding: 'utf-8' });
})();

function main() {
  console.log(execSync('ls'));
}

main();
