#!/bin/bash

$(dirname $0)/ci-scripts/init-env.js && /bin/bash

echo "source /ci-vault/.secrets-plain" >> ${process.env.CIRCLE_SHELL_ENV};

