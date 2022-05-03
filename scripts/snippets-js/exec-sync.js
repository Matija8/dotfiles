#!/usr/bin/env node

const execSync = (() => {
  const execSync = require('child_process').execSync;
  return (command) => execSync(command, { encoding: 'utf-8' });
})();

function write(text) {
  // Omits ending '\n' of console.log()
  process.stdout.write(text);
}

(function main() {
  console.log('ls returned:');
  write(execSync('ls'));
})();
