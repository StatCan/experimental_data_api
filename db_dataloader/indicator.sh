#!/bin/sh
a="/$0"; a=${a%/*}; a=${a#/}; a=${a:-.}; BASEDIR=$(cd "$a"; pwd)

indicator=$1

if [ ! -z "$indicator" ]; then
  cat ${indicator} | jq -r -f ${BASEDIR}/indicator.jq > tmp \
    &&  while [ ! -z "$(cat tmp | grep '\[UUID_HERE\]')" ];
      do sed -i -E -e '0,/\[UUID_HERE\]/ s|\[UUID_HERE\]|'$(uuidgen)'|' tmp ;
    done \
    && out=$(cat tmp) \
    && rm tmp \
    && echo "${out}"
fi
