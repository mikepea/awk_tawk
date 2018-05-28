#!/usr/bin/awk -f

BEGIN { FS="\n"; RS=""; } # multiline mode

function get_key() { RS="\n"; getline key < "-"; RS="" }
function refresh() { system("clear"); print "=== Slide " NR " ===" }
function alen(a) { c=0; for (i in a) c++; return c }
function empty_array(a) { split("", a, ":") }
function print_slide(slide) {
  l = alen(slide)
  for (i=1;i<=l;i++) {
    if ( slide[i] ~ /^@/ ) { continue }
    print ( slide[i] == "." ) ? "" : slide[i]
  }
}

{
  refresh()
  if ($1 ~ /^!/) {
    system(substr($1, 2)); empty_array(slide_cache)
  } else if ($1 ~ /^#/) next
  else {
    if ( $1 != "@last") empty_array(slide_cache)
    orig_len = alen(slide_cache)
    for (i=1; i<=NF; i++) {
      slide_cache[orig_len + i] = $i
    }
  }
}
NR >= ENVIRON["SS"] { print_slide(slide_cache); get_key() }
