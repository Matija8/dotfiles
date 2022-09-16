// https://stackoverflow.com/questions/47232518/write-a-typesafe-pick-function-in-typescript
// https://www.typescriptlang.org/docs/handbook/release-notes/typescript-2-1.html#partial-readonly-record-and-pick

function pick<T, K extends keyof T>(obj: T, ...keys: K[]): Pick<T, K> {
  const ret = {} as Pick<T, K>;
  keys.forEach((key) => {
    ret[key] = obj[key];
  });
  return ret;
}

const o = { a: 1, b: '2', c: 3 };
const picked = pick(o, 'b', 'c');

picked.a; // not allowed
picked.b; // string
picked.c; // number
