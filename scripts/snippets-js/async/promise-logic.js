#!/usr/bin/env node


/*
  Demonstrate difference between
  1) callbacks
  2) new Promise(slowFunc)
  3) Promise.resolve().then(slowFunc)
  4) async await???

  Slow is often called blocking
*/


const log = (msg) => console.log(`${msg} ${new Date() - start}ms`);
const start = new Date();

log('Sync Code 1 -> Start');

const success = (val) => log(`${val} -> Sucess`);
const fail = (val) => log(`${val} -> Fail`);

const doCallback = (err, succ) => {
  log('<blocking start>');
  // Blocking really just means slow -_-.
  for (let i = 0; i < 100000000; i++) {
    // Simulate slow op.
    const n = i*2;
  }
  log('<blocking end>');
  let n = Math.random();
  n = Number(n.toString().substr(0, 4));
  if (n > 0.5) {
    succ(n);
    succ(n);
  } else {
    err(n);
    err(n);
  }
};

const doPromiseSync = () => {
  return new Promise((res, rej) => {
    // When making a promise the function passed
    // to the Promise constructor is started synchronsly!
    log('Promise Sync Inside Start (slow)');
    doCallback(rej, res);
  });
};

const doPromiseAsync = () => {
  // The 2 lines below are the same!
  // return Promise.resolve('Promise Async then started').then(...)
  // return new Promise((resolve, _) => resolve('Promise Async then started')).then(...)

  return new Promise((resolve, _) => {
    // This is synchronous, but fast!!!
    log('Promise Async Inside Start (fast)');
    resolve('Promise Async then started');
  })
    .then( resolvedVal => {
      // But this is asynchronous!!!
      log(resolvedVal);
      return new Promise((res, rej) => {
        // log('Promise Async Returned Promise Start');
        doCallback(rej, res);
      });
    });
};

// TODO async await!!!
const asyncAwait = () => {
  return async () => {
    return new Promise((res, rej) => {
      // log('Async Await start');
      doCallback(rej, res);
    });
  };
};

log('Sync Code 2 -> Promise Async Start');

// Doesn't block sync stuff (best).
doPromiseAsync()
  .then((function IIFE() {
    log('Expression in then is evaluated synchronously');
    // This expression should evaluate to a function object!
    return val => val;
  })())
  .then(val => success(`Promise Async ${val}`))
  .catch(val => fail(`Promise Async ${val}`));

log('Sync Code 3 -> Promise Sync Start');

// Blocks sync stuff.
doPromiseSync()
  .then(val => {log('Promise Sync 1st then started'); return val;})
  .then(val => success(`Promise Sync ${val}`))
  .catch(val => fail(`Promise Sync ${val}`));

log('Sync Code 4 -> Callback Start');

// Blocks sync stuff and can call multiple times (worst!).
doCallback(val => fail(`Callback ${val}`), val => success(`Callback ${val}`));

log('Sync Code 5 -> Last Sync Code!');

