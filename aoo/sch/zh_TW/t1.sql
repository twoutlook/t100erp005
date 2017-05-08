update oogc_t set oogc004 = '1'
WHERE oogcent = 99
and oogc001 = '1'
and oogc002 = '1'
and to_char(to_date(oogc003,'yyyy/mm/dd'),'dy') = 'sat'

/
