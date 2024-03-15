#!/bin/sh

cat <<EOF > commitlint.config.js
module.exports = {
  rules: {
    'type-enum': [2, 'always', ['feat']],
  },
};
EOF
