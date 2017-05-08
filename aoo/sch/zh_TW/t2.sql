select oogc003,to_char(to_date(oogc003,'yyyy/mm/dd'),'dy')
 from oogc_t where oogcent = 99 and oogc001 = '1' and oogc002 ='1' and (oogc003 between '2014-04-18' and '2014-04-25')
