#!/bin/bash
ca=$HOME/.aliases/common_aliases
[ -f $ca ] && /bin/rm -f $ca
for af in ~/.aliases/*.alias ; do
   /bin/cat $af >> $ca
done
