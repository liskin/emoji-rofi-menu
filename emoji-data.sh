#!/usr/bin/env bash

set -eu

curl -Ssf -L \
	-o en1.xml https://github.com/unicode-org/cldr/raw/release-37/common/annotations/en.xml \
	-o en2.xml https://github.com/unicode-org/cldr/raw/release-37/common/annotations/en_001.xml \
	-o en3.xml https://github.com/unicode-org/cldr/raw/release-37/common/annotationsDerived/en.xml \
	-o en4.xml https://github.com/unicode-org/cldr/raw/release-37/common/annotationsDerived/en_001.xml

jq_code='
	def to_dict: {(."@cp"): {(if ."@type" == "tts" then "name" else "keywords" end): (."#text")}};
	def merge: reduce .[] as $x ({}; . * $x);
	def out: .key + " " + .value.name + " (" + .value.keywords + ")";
	[ .[].ldml.annotations.annotation[] | to_dict ] | merge | to_entries[] | out
'
xq -r -s "$jq_code" en{1..4}.xml
