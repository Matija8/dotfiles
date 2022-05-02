#!/usr/bin/env node

const readline = require('readline');

function askQuestion(query) {
  const rl = readline.createInterface({
    input: process.stdin,
    output: process.stdout,
  });
  return new Promise((resolve) =>
    rl.question(query, (ans) => {
      rl.close();
      resolve(ans);
    }),
  );
}

(async function main() {
  const ans = await askQuestion(
    'Are you sure you want to deploy to PRODUCTION? ',
  );
  console.log(`You said ${ans.trim()}`);
})();
