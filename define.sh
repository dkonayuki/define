#!/bin/bash
if [ $# -eq 0 ]; then
  IFS= read -r -p 'Define: ' word
else
  word="$*"
fi

RED=$(tput setaf 1)
BLUE=$(tput setaf 4)
RESET=$(tput sgr0)

curl -s -A 'Mozilla/4.0' "http://www.dictionary.com/browse/$word" | html2text -ascii -nobs -style compact -width 500 | sed -r -n '/^\*\*\*\*\*\*/,/^Origin|^Expand/p' | sed -r -e '/Spell|\*|^See_more/d' | sed -e '$d' | sed -e '1d' | sed -r -e "s/  noun.*|  verb.*|  Verb.*|  adjective.*|  Idioms.*/${RED}&${RESET}/" | sed -e "s/^\[.*$/${BLUE}&${RESET}/"
