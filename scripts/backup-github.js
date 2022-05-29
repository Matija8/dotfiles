#!/usr/bin/env node

const fs = require('fs').promises;
const path = require('path');
const os = require('os');
const { exec } = require('child_process');
const fetch = require('node-fetch'); // node-fetch@2

async function main() {
  const ghBackupDirPath = path.join(os.homedir(), 'Documents', 'github-backup');
  // await fs.rm(ghBackupDirPath, { recursive: true, force: true });
  await fs.mkdir(ghBackupDirPath, { recursive: true });
  const repos = await getReposFromGithub();
  console.log(`${repos.length} repos found on github`);

  // console.log(`*$`, { repos }); //T*DO

  return;

  // TODO: Promise.all vs simple loop?
  for (const repo of repos) {
    await sh(
      `cd ${ghBackupDirPath}` + ` && pwd` + ` && git clone ${repo.ssh_url}`,
    )
      .catch((err) => console.log(err))
      .then(logSh);
  }

  await (async function cloneAppRepos() {
    await Promise.all(
      repos.map((repo) =>
        sh(
          `cd ${ghBackupDirPath}` + ` && pwd` + ` && git clone ${repo.ssh_url}`,
        )
          .catch((err) => emptyShLogResponse())
          .then(logShQ),
      ),
    );
  })();

  const repoPaths = repos.map((repo) => path.join(ghBackupDirPath, repo));
  await (async function checkoutDevOnAllRepoDirs() {
    await Promise.all(
      repoPaths.map(async (repoPath) => {
        await sh(`cd ${repoPath} && git checkout dev`);
      }),
    );
  })();

  await (async function pullLatestOnAllRepoDirs() {
    await Promise.all(
      repoPaths.map(async (repoPath) => {
        await sh(`cd ${repoPath} && pwd && git status -sb && git pull`).then(
          logSh,
        );
      }),
    );
  })();
}

async function getReposFromGithub() {
  // TODO:
  // https://docs.github.com/en/rest/guides/basics-of-authentication
  let apps = await fetch('https://api.github.com/users/matija8/repos').then(
    (res) => res.json(),
  );
  return apps;
}

async function sh(cmd) {
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

function logShQ({ stderr, stdout }) {
  stderr && console.error('stderr: ' + stderr);
  stdout && logStdOut(stdout);
  return { stderr, stdout };
}

function logSh({ stderr, stdout }) {
  stderr && console.error('stderr: ' + stderr);
  logStdOut(stdout);
  return { stderr, stdout };
}

function logStdOut(stdout) {
  // console.log('---stdout start---\n' + stdout + '---stdout end---\n');
  console.log(stdout);
}

function emptyShLogResponse() {
  return { stderr: '', stdout: '' };
}

main();
