###
# TLDR yarn install command:
yarn add -D jest babel-jest @babel/core @babel/preset-env @babel/preset-typescript
# npm i -D ...

#####
# Detailed explanation:

###
# Add jest
yarn add -D jest

###
# Add babel to enable TypeScript
# https://jestjs.io/docs/getting-started#using-babel
# https://jestjs.io/docs/getting-started#using-typescript
yarn add -D babel-jest @babel/core @babel/preset-env @babel/preset-typescript

###
# Copy babel.config.js to the project root!
# Tests should work from the CLI now.
touch ./babel.config.js

###
# Add "types", "include", and "exclude" to tsconfig.json
# This is to fix VSCode type hints
# https://stackoverflow.com/a/62436103
touch ./tsconfig.json

###
# Create jest.config.js
# and ignore tests in dist/ directory.
# (*.test.ts files shouldn't be compiled to dist/, but better be safe)
# https://jestjs.io/docs/getting-started#additional-configuration
jest --init
