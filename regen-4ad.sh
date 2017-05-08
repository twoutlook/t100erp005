cd $ERP
rm /tmp/regen-4ad.log
systems=`ls -d a?? `
for d in $systems
do
    if [ ! "$d" = "adz" ]
    then
    if [ ! "$d" = "ait" ]
    then
       echo $d
       cd $ERP/$d/4ad/zh_TW
       prg=`ls *.4ad`
       for i in $prg
       do
         cd $ERP/$d/4gl
         prog_name=`echo $i | cut -d'.' -f1`
         echo $prog_name
       
export T100RUNWAIT=1
         r.r azzp195 $prog_name >>/tmp/regen-4ad.log 2>>/tmp/regen-4ad.log 
     #   r.r azzp193 $prog_name 4ad zh_CN >>/tmp/regen-4ad.log 2>>/tmp/regen-4ad.log 
     #   r.r azzp191 $prog_name zh_TW >>/tmp/regen-4ad.log 2>>/tmp/regen-4ad.log 
     #   r.r azzp191 $prog_name zh_CN >>/tmp/regen-4ad.log 2>>/tmp/regen-4ad.log 
#export T100RUNWAIT=0
    #    r.r azzp193 $prog_name 4tm zh_TW >>/tmp/regen-4ad.log 2>>/tmp/regen-4ad.log 
    #    r.r azzp193 $prog_name 4tm zh_CN >>/tmp/regen-4ad.log 2>>/tmp/regen-4ad.log 
    #    r.r azzp193 $prog_name 4ad zh_TW >>/tmp/regen-4ad.log 2>>/tmp/regen-4ad.log 
         r.r azzp185 admin-01 $prog_name >>/tmp/regen-4ad.log 2>>/tmp/regen-4ad.log 
       done
    fi
    fi
done

