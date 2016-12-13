#!/bin/sh

# Minify Javascript : exemple  sh min.sh core.js core.min.js



curl -X POST -s --data-urlencode 'input@$1' https://javascript-minifier.com/raw > $2
