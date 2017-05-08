cd $ADZ/4gl

#export DBDATE=Y4MD/
#r.cs adzp030
#r.cs sadzp030_tab
#r.cs sadzp030_tab_de
#r.cs sadzp030_tab_ma
#r.cs sadzp030_tab_file
#r.cs sadzp030_tab_relation
#r.cs sadzp180_free
#r.cs sadzp188_gen4rp
#r.cs sadzp188_tab
#
#fgl2p -o adzp030.42r adzp030.42m libgre.42x sadzp030_tab.42m sadzp030_tab_de.42m sadzp030_tab_ma.42m sadzp030_tab_file.42m sadzp030_tab_relation.42m sadzp180_free.42m lib.42x sub.42x qry.42x sadzp188_gen4rp.42m sadzp188_tab.42m

$FGLRUN $ADZ/42r/adzp030.42r ${1} ${2} ${3} 

