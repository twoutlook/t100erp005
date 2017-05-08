cd $ERP
export T100RUNWAIT=1
rm /tmp/regen-42s.log
systems=`ls -d a?? `
for d in $systems
do
    if [ ! "$d" = "adz" ]
    then
    if [ ! "$d" = "ait" ]
    then
       echo $d
       cd $ERP/$d/42s/zh_TW
       prg=`ls *.42s`
       for i in $prg
       do
         cd $ERP/$d/4gl
         prog_name=`echo $i | cut -d'.' -f1`
         echo $prog_name
       
         $FGLRUN $AZZ/4gl/test-noent $d $prog_name >> /tmp/regen-noent.log
     #   r.r azzp195 $prog_name 
     #   r.r azzp193 $prog_name 42s zh_CN >>/tmp/regen-42s.log 2>>/tmp/regen-42s.log 
    #    r.r azzp191 $prog_name zh_TW >>/tmp/regen-42s.log 2>>/tmp/regen-42s.log 
    #    r.r azzp191 $prog_name zh_CN >>/tmp/regen-42s.log 2>>/tmp/regen-42s.log 
     #    r.r azzp193 $prog_name 4tm zh_TW >>/tmp/regen-42s.log 2>>/tmp/regen-42s.log 
     #    r.r azzp193 $prog_name 4tm zh_CN >>/tmp/regen-42s.log 2>>/tmp/regen-42s.log 
     #    r.r azzp193 $prog_name 42s zh_TW >>/tmp/regen-42s.log 2>>/tmp/regen-42s.log 
     #    r.r azzp185 admin-01 $prog_name >>/tmp/regen-42s.log 2>>/tmp/regen-42s.log 
       done
    fi
    fi
done

