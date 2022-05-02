const { exec } = require('child_process');

async function run(cmd) {
  return new Promise(function (resolve, reject) {
    exec(cmd, (err, stdout, stderr) => {
      if (err) {
        reject(err);
      } else {
        resolve({ stdout, stderr });
      }
    });
  });
}

function logSh({ stderr, stdout }) {
  stderr && logStdErr(stderr);
  logStdOut(stdout);
  return { stderr, stdout };
}

function logShQErr({ stderr, stdout }) {
  stderr && logStdErr(stderr);
  stdout && logStdOut(stdout);
  return { stderr, stdout };
}

function logStdOut(stdout) {
  // console.log('---stdout start---\n' + stdout + '---stdout end---\n');
  console.log(stdout);
}

function logStdErr(stderr) {
  console.error('stderr: ' + stderr);
}

function emptyShLogResponse() {
  return { stderr: '', stdout: '' };
}

// run('...').catch(ignoreErr).then(logSh),
function ignoreErr() {
  return emptyShLogResponse;
}

module.exports = {
  run,
  runP: (cmd) => run(cmd).then(logSh), // Run & print
  runPerr: (cmd) => run(cmd).then(logShQErr), // Run & print stderr only
  logSh,
  logShQ: logShQErr,
  ignoreErr,
};
