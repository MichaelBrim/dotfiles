cdup () 
{ 
    cnt=${1:-1};
    while [ $cnt -ne 0 ]; do
        cd ..;
        cnt=`expr $cnt - 1`;
    done
}
