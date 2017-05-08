export DBDATE=Y4MD
cd $ERP
systems=`ls -d a?? `
for d in $systems
do
    if [ ! "$d" = "adz" ]
    then
    if [ ! "$d" = "ait" ]
    then
       echo $d
       cd $ERP/$d/dzx/tab
       prg=`ls *.tab`
       for i in $prg
       do
         prog_name=`echo $i | cut -d'.' -f1`
         echo $prog_name

       # cd $ERP/$d/dzx/tab
       # cp $prog_name.tab $prog_name.bak140408

         cd $ERP/adz/4gl
         $FGLRUN $ADZ/42r/adzp030.42r $prog_name >> $LOGDIR/regen-tab_$ZONE.log  2>&1
       done
    fi
    fi
done

