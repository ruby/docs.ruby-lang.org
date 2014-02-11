#!/bin/bash
YEAR=${1:-`date +%Y`}
MONTH=${2:-`date +%m`}
RELEASE_MONTH="${YEAR}${MONTH}"
cd /var/www/docs.ruby-lang.org/archives/${RELEASE_MONTH}
md5sum r* > MD5SUM.txt
sha1sum r* > SHA1SUM.txt

