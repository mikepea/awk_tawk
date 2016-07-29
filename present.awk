#!/usr/bin/awk -f

BEGIN {
  FS="\n";  # lines are fields
  RS="";    # multiline records
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
        # hack to work add newlines
        print ""
      } else {
        # print line (aka field)
        print $i
      }
    }

  }
  # reset our RS so we can read a single
  # newline from STDIN
  RS="\n"; getline key < "-"; RS=""
}

