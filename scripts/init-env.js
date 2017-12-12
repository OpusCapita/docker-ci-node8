#!/usr/bin/env node

let run = require('./run');

run(`
  mkdir /ci-vault &&
  git clone git@github.com:OpusCapita/machineuser-vault.git /ci-vault
`);

run(`
  cd /ci-vault &&
  openssl aes-256-cbc -d -in .secrets -out .secrets-plain -k ${process.env.MACHINEUSER_VAULT_KEY}
`);

run(`
  echo "source /ci-vault/.secrets-plain" >> ${process.env.BASH_ENV};
`);

