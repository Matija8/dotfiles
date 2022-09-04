import express, { Router } from 'express';
import path from 'path';

export function serveFrontendRouter(): Router {
  // For CSR (Client Side Rendered) React apps.
  const router = express.Router();
  const buildDir = path.join(__dirname, '../../../client/build');
  router.use(express.static(buildDir));
  // Route dynamic routes to the react app.
  router.get('*', (req, res) => {
    res.sendFile(path.join(buildDir, '/index.html'));
  });
  return router;
}
