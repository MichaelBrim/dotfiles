#!/bin/bash
ca=$HOME/.aliases/common_aliases
[ -f $ca ] && /bin/mv $ca ${ca}.prev
for af in ~/.aliases/*.alias ; do
   /bin/cat $af >> $ca
   echo >> $ca
done
