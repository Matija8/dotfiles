// Just use zod/yup if you can

const validationRegexes = {
  email:
    /^(([^<>()[\]\.,;:\s@\"]+(\.[^<>()[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$/i,
};

const errors: Record<string, string> = {};

if (!validationRegexes.email.test('bad-email@asd')) {
  errors.email = '*Nevalidan e-mail';
}
