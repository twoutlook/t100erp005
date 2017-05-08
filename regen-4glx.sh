cd $ERP
rm /tmp/regen-4gl.log
systems=`ls -d $1 `
for d in $systems
do
    if [ ! "$d" = "adz" ]
    then
       echo $d
       cd $ERP/$d/4gl
       prg=`ls *.4gl`
       for i in $prg
       do
         cd $ERP/$d/4gl
         prog_name=`echo $i | cut -d'.' -f1`
         cp $prog_name.4gl $prog_name.bwk
         echo $prog_name
         r.c3 $prog_name '' A >>/tmp/regen-4gl.log 2>>/tmp/regen-4gl.log 
       done
    fi
done

