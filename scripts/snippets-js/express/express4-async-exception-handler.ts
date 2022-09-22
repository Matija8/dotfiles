// https://stackoverflow.com/questions/51391080/handling-errors-in-express-async-middleware
// Exceptions in sync functions are caught by default.
// Exceptions in async functions are not :(.
// This should work out-of-the-box in Express 5.
import { NextFunction, Request, RequestHandler, Response } from 'express';

export const asyncHandler =
  (fn: RequestHandler) =>
  (req: Request, res: Response, next: NextFunction): Promise<void> => {
    return Promise.resolve(fn(req, res, next)).catch(next);
  };

export const ah = asyncHandler;

// #############################################################################

// USAGE:
app.use(ah(async(req, res, next) => {
  await authenticate(req);
  next();
}));

app.get('/async', ah(async(req, res) => {
  const result = await request('http://example.com');
  res.end(result);
}));

// Any rejection will go to the error handler
