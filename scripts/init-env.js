#!/usr/bin/env node

let run = require('./run');

run(`
  mkdir /ci-vault &&
  git clone --depth 1 git@github.com:OpusCapita/machineuser-vault.git /ci-vault
`);

run(`
  cd /ci-vault &&
  openssl aes-256-cbc -d -in .secrets -out .secrets-plain -k ${process.env.MACHINEUSER_VAULT_KEY}
`);

