cd $ERP
#rm $LOGDIR/regen-4gl_$ZONE.log
systems=`ls -d a[pqrstuvwxyz]? `
for d in $systems
do
    if [ ! "$d" = "adz" ]
    then
    if [ ! "$d" = "ait" ]
    then
       echo $d
       cd $ERP/$d/4gl
       prg=`ls *.4gl`
       for i in $prg
       do
         cd $ERP/$d/4gl
         prog_name=`echo $i | cut -d'.' -f1`
        #cp $prog_name.4gl $prog_name.bwk
         echo $prog_name
         r.c3 $prog_name '' A >> $LOGDIR/regen-4gl_$ZONE.log 2>&1
       done
    fi
    fi
done

