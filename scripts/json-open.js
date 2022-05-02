#!/usr/bin/env node

const fs = require('fs');

// Use this script to quickly analyze json files.

const fpath = './TODO.json';
const data = JSON.parse(fs.readFileSync(fpath));
console.log(data.length);
