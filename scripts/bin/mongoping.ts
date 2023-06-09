#!/usr/bin/env -S deno run --allow-env --allow-net

import { MongoClient } from 'https://deno.land/x/mongo/mod.ts';

const client = new MongoClient();
await client.connect('mongodb://localhost:27017');
console.log('Connecting successful');
const dbs = await client.listDatabases();
console.log(
  'databases:',
  dbs.map(
    (db) =>
      `${db.name}    ${
        db.sizeOnDisk && (db.sizeOnDisk / 1024 / 1024 / 1024).toFixed(4)
      } GB`,
  ),
);

if (0) {
  dbs.map(async (db) => {
    const collections = await client.database(db.name).listCollectionNames();
    console.log({ db: db.name, collections });
  });
}
