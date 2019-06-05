#!/usr/bin/env bash

set -eu

curl -Ssf -L \
	-O https://github.com/unicode-org/cldr/raw/release-35-1/common/annotations/en.xml \
	-O https://github.com/unicode-org/cldr/raw/release-35-1/common/annotations/en_001.xml

jq_code='
	def to_dict: {(."@cp"): {(if ."@type" == "tts" then "name" else "keywords" end): (."#text")}};
	def merge: reduce .[] as $x ({}; . * $x);
	def out: .key + " " + .value.name + " (" + .value.keywords + ")";
	[ .[].ldml.annotations.annotation[] | to_dict ] | merge | to_entries[] | out
'
xq -r -s "$jq_code" en.xml en_001.xml
