#!/bin/bash

show_help() {
echo "
Program calculates the permissions from umask
Version: 0.1
Umask min and max for directores is 000 and 777 and for files 000 and 666.

Run the program with the umask in octal as first parameter
umask_calc 022
"
exit 1
}

if [ $# -eq 0 ]; then show_help; fi

calc_perm() {
  decvalue=$(echo "ibase=8;obase=12;$1" | bc)
  decmax=$(echo "ibase=8;obase=12;$2" | bc)
  decvalueneg=$(echo $(( ~${decvalue} )))
  decmask=$(echo $((${decvalueneg}&${decmax})) )
  echo "obase=8;${decmask}" | bc
}

echo "File Mode: $(calc_perm $1 666)"
echo "Directory Mode: $(calc_perm $1 777)"
