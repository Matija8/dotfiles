#!/usr/bin/env node

const fs = require('fs').promises;
const path = require('path');
const os = require('os');
const { exec } = require('child_process');
const fetch = require('node-fetch'); // node-fetch@2

const gUsername = 'matija8';

async function main() {
  const ghBackupDirPath = path.join(os.homedir(), 'Documents', 'github-backup');
  await fs.rm(ghBackupDirPath, { recursive: true, force: true });
  await fs.mkdir(ghBackupDirPath, { recursive: true });
  const repos = await getReposFromGithub();
  console.log(`${repos.length} repos found on github`);

  for (const repo of repos) {
    await sh(`cd ${ghBackupDirPath}` + ` && git clone ${repo.ssh_url}`)
      .catch((err) => console.log(err))
      .then(logSh);
  }
}

async function getAuthHeaders() {
  // https://docs.github.com/en/rest/guides/getting-started-with-the-rest-api#using-personal-access-tokens
  const ghPersonalAccessToken =
    process.env['GH_PAT'] ||
    (await fs.readFile(path.join(__dirname, 'gh-pat.txt'), 'utf-8')).trim();

  if (!ghPersonalAccessToken) throw Error('PAT Missing!');

  return {
    Authorization:
      'Basic ' +
      Buffer.from(gUsername + ':' + ghPersonalAccessToken).toString('base64'),
  };
}

async function getUserData() {
  return await fetch(`https://api.github.com/user`, {
    headers: await getAuthHeaders(),
  }).then((res) => res.json());
}

async function testAuth() {
  const user = await getUserData();
  if (!user.total_private_repos) throw Error('Auth failed!?');
}

async function getReposFromGithub() {
  await testAuth();
  const headers = await getAuthHeaders();

  let user = await fetch(`https://api.github.com/user`, {
    headers,
  }).then((res) => res.json());
  if (!user.total_private_repos) throw Error('Auth failed!?');

  // This call doesn't work:
  // https://api.github.com/users/${gUsername}/repos
  // https://github.community/t/how-to-get-list-of-private-repositories-via-api-call/120175
  // https://docs.github.com/en/rest/search#search-repositories
  const MAX_PER_PAGE = 100;
  let repos = await fetch(
    `https://api.github.com/search/repositories?q=user:${gUsername}&per_page=${MAX_PER_PAGE}`,
    {
      headers,
    },
  ).then((res) => res.json());
  repos = repos.items;
  return repos;
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
