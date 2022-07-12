#!/bin/bash

set -e

npm link $(ls -1 $(npm root -g)/)
cypress run --spec cypress/e2e/2-advanced-examples/actions.cy.js --browser chrome
