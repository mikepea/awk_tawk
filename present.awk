#!/usr/bin/awk -f

BEGIN {
  FS="\n";  # lines are fields
  RS="";    # multiline records (RS effectively \n\n+)
}

function get_key() {
  # reset our RS so we can read a single newline from STDIN
  RS="\n"; getline key < "-"; RS=""
}

{
  system("clear"); print ""

  if ($1 ~ /^!/) {
    # command executor
    system(substr($1, 2));
  } else {
    # regular slide:
    for (i=1; i<=NF; i++) {
      if ($i == ".") {
        print "" # hack to include newlines in slides
      } else {
        print $i # print line (aka field)
      }
    }

  }
  get_key()
}

