#!/usr/bin/env -S deno run --allow-env --allow-net

import { MongoClient } from 'https://deno.land/x/mongo/mod.ts';

const client = new MongoClient();

try {
  await client.connect('mongodb://localhost:27017');
  console.log('Connecting successful');
  const dbs = await client.listDatabases();
  console.log({ dbs });

  if (0) {
    await Promise.all(
      dbs.map(async (db) => {
        const database = client.database(db.name);
        const collections = await database.listCollectionNames();
        console.log({ collections });
      }),
    );
  }
} catch (err) {
  console.error('error', { err });
} finally {
  client.close();
}
