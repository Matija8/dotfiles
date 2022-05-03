const { exec, execSync } = require('child_process');

/**
 * @typedef ConsoleOutput
 * @property {string} stdout
 * @property {string} stderr
 */

/**
 * Run shell command and return promise of stdout & stderr.
 * @param {string} command Shell command to be run.
 * @returns {Promise<ConsoleOutput>}
 */
async function run(command) {
  return new Promise(function (resolve, reject) {
    exec(command, (err, stdout, stderr) => {
      if (err) {
        reject(err);
      } else {
        resolve({ stdout, stderr });
      }
    });
  });
}

/**
 * @param {string} command Shell command to be run.
 * @returns {string}
 */
function runSync(command) {
  const res = runSyncQuiet(command);
  process.stdout.write(res);
  return res;
}

/**
 * https://nodejs.org/api/child_process.html#child_processexecsynccommand-options
 * @param {string} command Shell command to be run.
 * @returns {string}
 */
function runSyncQuiet(command) {
  return execSync(command, { encoding: 'utf-8' });
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
  runs: runSync,
  runsq: runSyncQuiet,
  logSh,
  logShQ: logShQErr,
  ignoreErr,
};
