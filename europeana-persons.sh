#!/bin/bash

# get person subpages known to Internet Archive
curl -s 'http://web.archive.org/cdx/search/cdx?url=pro.europeana.eu/person/&matchType=prefix&output=json' \
    | jq -r '.[][2]' | sed 's!.*person/!!' > tmp

# get person pages listed at EuropeanaTech 2018 program page
curl -s https://pro.europeana.eu/page/europeanatech-2018-programme \
    | pup 'a attr{href}' | grep 'pro.europeana.eu/person/' \
    | sed 's!.*person/!!' | sort | uniq >> tmp

# merge
grep -v '\.' tmp | sort | uniq \
    | awk '{print "https://pro.europeana.eu/person/" $0 }' > persons
