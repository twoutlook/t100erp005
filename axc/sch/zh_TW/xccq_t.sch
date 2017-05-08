/* 
================================================================================
檔案代號:xccq_t
檔案名稱:料件庫存成本期異動明細統計檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:S
多語系檔案:N
============.========================.==========================================
 */
create table xccq_t
(
xccqent       number(5)      ,/* 企業編號 */
xccqcomp       varchar2(10)      ,/* 法人組織 */
xccqld       varchar2(5)      ,/* 帳套 */
xccqsite       varchar2(10)      ,/* 營運組織 */
xccq001       varchar2(1)      ,/* 帳套本位幣順序 */
xccq002       varchar2(30)      ,/* 成本域 */
xccq003       varchar2(10)      ,/* 成本計算類型 */
xccq004       number(5,0)      ,/* 年度 */
xccq005       number(5,0)      ,/* 期別 */
xccq006       varchar2(40)      ,/* 料號 */
xccq007       varchar2(256)      ,/* 特性碼 */
xccq008       varchar2(30)      ,/* 批號 */
xccq009       varchar2(30)      ,/* 庫存管理特徵 */
xccq010       varchar2(10)      ,/* 倉庫 */
xccq011       varchar2(10)      ,/* 儲位 */
xccq012       varchar2(10)      ,/* 品類 */
xccq101       number(20,6)      ,/* 上期結存數量 */
xccq102       number(20,6)      ,/* 上期結存金額 */
xccq102a       number(20,6)      ,/* 上期結存金額-材料 */
xccq102b       number(20,6)      ,/* 上期結存金額-人工 */
xccq102c       number(20,6)      ,/* 上期結存金額-加工 */
xccq102d       number(20,6)      ,/* 上期結存金額-制費一 */
xccq102e       number(20,6)      ,/* 上期結存金額-製費二 */
xccq102f       number(20,6)      ,/* 上期結存金額-製費三 */
xccq102g       number(20,6)      ,/* 上期結存金額-制費四 */
xccq102h       number(20,6)      ,/* 上期結存金額-製費五 */
xccq201       number(20,6)      ,/* 本期採購入庫數量 */
xccq202       number(20,6)      ,/* 本期採購入庫金額 */
xccq202a       number(20,6)      ,/* 本期採購入庫金額-材料 */
xccq202b       number(20,6)      ,/* 本期採購入庫金額-人工 */
xccq202c       number(20,6)      ,/* 本期採購入庫金額-加工 */
xccq202d       number(20,6)      ,/* 本期採購入庫金額-製費一 */
xccq202e       number(20,6)      ,/* 本期採購入庫金額-制費二 */
xccq202f       number(20,6)      ,/* 本期採購入庫金額-制費三 */
xccq202g       number(20,6)      ,/* 本期採購入庫金額-制費四 */
xccq202h       number(20,6)      ,/* 本期採購入庫金額-制費五 */
xccq203       number(20,6)      ,/* 本期委外入庫數量 */
xccq204       number(20,6)      ,/* 本期委外入庫金額 */
xccq204a       number(20,6)      ,/* 本期委外入庫金額-材料 */
xccq204b       number(20,6)      ,/* 本期委外入庫金額-人工 */
xccq204c       number(20,6)      ,/* 本期委外入庫金額-加工 */
xccq204d       number(20,6)      ,/* 本期委外入庫金額-製費一 */
xccq204e       number(20,6)      ,/* 本期委外入庫金額-制費二 */
xccq204f       number(20,6)      ,/* 本期委外入庫金額-製費三 */
xccq204g       number(20,6)      ,/* 本期委外入庫金額-製費四 */
xccq204h       number(20,6)      ,/* 本期委外入庫金額-製費五 */
xccq205       number(20,6)      ,/* 本期工單入庫數量 */
xccq206       number(20,6)      ,/* 本期工單入庫金額 */
xccq206a       number(20,6)      ,/* 本期工單入庫金額-材料 */
xccq206b       number(20,6)      ,/* 本期工單入庫金額-人工 */
xccq206c       number(20,6)      ,/* 本期工單入庫金額-加工 */
xccq206d       number(20,6)      ,/* 本期工單入庫金額-製費一 */
xccq206e       number(20,6)      ,/* 本期工單入庫金額-製費二 */
xccq206f       number(20,6)      ,/* 本期工單入庫金額-制費三 */
xccq206g       number(20,6)      ,/* 本期工單入庫金額-製費四 */
xccq206h       number(20,6)      ,/* 本期工單入庫金額-制費五 */
xccq207       number(20,6)      ,/* 本期重工領出數量 */
xccq208       number(20,6)      ,/* 本期重工領出金額 */
xccq208a       number(20,6)      ,/* 本期重工領出金額-材料 */
xccq208b       number(20,6)      ,/* 本期重工領出金額-人工 */
xccq208c       number(20,6)      ,/* 本期重工領出金額-加工 */
xccq208d       number(20,6)      ,/* 本期重工領出金額-製費一 */
xccq208e       number(20,6)      ,/* 本期重工領出金額-製費二 */
xccq208f       number(20,6)      ,/* 本期重工領出金額-制費三 */
xccq208g       number(20,6)      ,/* 本期重工領出金額-製費四 */
xccq208h       number(20,6)      ,/* 本期重工領出金額-制費五 */
xccq209       number(20,6)      ,/* 本期重工入庫數量 */
xccq210       number(20,6)      ,/* 本期重工入庫金額 */
xccq210a       number(20,6)      ,/* 本期重工入庫金額-材料 */
xccq210b       number(20,6)      ,/* 本期重工入庫金額-人工 */
xccq210c       number(20,6)      ,/* 本期重工入庫金額-加工 */
xccq210d       number(20,6)      ,/* 本期重工入庫金額-製費一 */
xccq210e       number(20,6)      ,/* 本期重工入庫金額-製費二 */
xccq210f       number(20,6)      ,/* 本期重工入庫金額-製費三 */
xccq210g       number(20,6)      ,/* 本期重工入庫金額-製費四 */
xccq210h       number(20,6)      ,/* 本期重工入庫金額-制費五 */
xccq211       number(20,6)      ,/* 本期雜項入庫數量 */
xccq212       number(20,6)      ,/* 本期雜項入庫金額 */
xccq212a       number(20,6)      ,/* 本期雜項入庫金額-材料 */
xccq212b       number(20,6)      ,/* 本期雜項入庫金額-人工 */
xccq212c       number(20,6)      ,/* 本期雜項入庫金額-加工 */
xccq212d       number(20,6)      ,/* 本期雜項入庫金額-製費一 */
xccq212e       number(20,6)      ,/* 本期雜項入庫金額-制費二 */
xccq212f       number(20,6)      ,/* 本期雜項入庫金額-製費三 */
xccq212g       number(20,6)      ,/* 本期雜項入庫金額-制費四 */
xccq212h       number(20,6)      ,/* 本期雜項入庫金額-製費五 */
xccq213       number(20,6)      ,/* 本期調整入庫數量 */
xccq214       number(20,6)      ,/* 本期調整入庫金額 */
xccq214a       number(20,6)      ,/* 本期調整入庫金額-材料 */
xccq214b       number(20,6)      ,/* 本期調整入庫金額-人工 */
xccq214c       number(20,6)      ,/* 本期調整入庫金額-加工 */
xccq214d       number(20,6)      ,/* 本期調整入庫金額-制費一 */
xccq214e       number(20,6)      ,/* 本期調整入庫金額-制費二 */
xccq214f       number(20,6)      ,/* 本期調整入庫金額-製費三 */
xccq214g       number(20,6)      ,/* 本期調整入庫金額-製費四 */
xccq214h       number(20,6)      ,/* 本期調整入庫金額-制費五 */
xccq215       number(20,6)      ,/* 本期銷退入庫數量 */
xccq216       number(20,6)      ,/* 本期銷退入庫金額 */
xccq216a       number(20,6)      ,/* 本期銷退入庫金額-材料 */
xccq216b       number(20,6)      ,/* 本期銷退入庫金額-人工 */
xccq216c       number(20,6)      ,/* 本期銷退入庫金額-加工 */
xccq216d       number(20,6)      ,/* 本期銷退入庫金額-制費一 */
xccq216e       number(20,6)      ,/* 本期銷退入庫金額-制費二 */
xccq216f       number(20,6)      ,/* 本期銷退入庫金額-製費三 */
xccq216g       number(20,6)      ,/* 本期銷退入庫金額-製費四 */
xccq216h       number(20,6)      ,/* 本期銷退入庫金額-製費五 */
xccq217       number(20,6)      ,/* 本期調撥入庫數量 */
xccq218       number(20,6)      ,/* 本期調撥入庫金額 */
xccq218a       number(20,6)      ,/* 本期調撥入庫金額-材料 */
xccq218b       number(20,6)      ,/* 本期調撥入庫金額-人工 */
xccq218c       number(20,6)      ,/* 本期調撥入庫金額-加工 */
xccq218d       number(20,6)      ,/* 本期調撥入庫金額-製費一 */
xccq218e       number(20,6)      ,/* 本期調撥入庫金額-製費二 */
xccq218f       number(20,6)      ,/* 本期調撥入庫金額-製費三 */
xccq218g       number(20,6)      ,/* 本期調撥入庫金額-製費四 */
xccq218h       number(20,6)      ,/* 本期調撥入庫金額-製費五 */
xccq280       number(20,6)      ,/* 本期平均單價 */
xccq280a       number(20,6)      ,/* 本期平均單價-材料 */
xccq280b       number(20,6)      ,/* 本期平均單價-人工 */
xccq280c       number(20,6)      ,/* 本期平均單價-加工 */
xccq280d       number(20,6)      ,/* 本期平均單價-製費一 */
xccq280e       number(20,6)      ,/* 本期平均單價-制費二 */
xccq280f       number(20,6)      ,/* 本期平均單價-制費三 */
xccq280g       number(20,6)      ,/* 本期平均單價-製費四 */
xccq280h       number(20,6)      ,/* 本期平均單價-製費五 */
xccq301       number(20,6)      ,/* 本期工單領用數量 */
xccq302       number(20,6)      ,/* 本期工單領用金額 */
xccq302a       number(20,6)      ,/* 本期工單領用金額-材料 */
xccq302b       number(20,6)      ,/* 本期工單領用金額-人工 */
xccq302c       number(20,6)      ,/* 本期工單領用金額-加工 */
xccq302d       number(20,6)      ,/* 本期工單領用金額-製費一 */
xccq302e       number(20,6)      ,/* 本期工單領用金額-製費二 */
xccq302f       number(20,6)      ,/* 本期工單領用金額-製費三 */
xccq302g       number(20,6)      ,/* 本期工單領用金額-製費四 */
xccq302h       number(20,6)      ,/* 本期工單領用金額-製費五 */
xccq303       number(20,6)      ,/* 本期銷貨數量 */
xccq304       number(20,6)      ,/* 本期銷貨成本 */
xccq304a       number(20,6)      ,/* 本期銷貨成本-材料 */
xccq304b       number(20,6)      ,/* 本期銷貨成本-人工 */
xccq304c       number(20,6)      ,/* 本期銷貨成本-加工 */
xccq304d       number(20,6)      ,/* 本期銷貨成本-製費一 */
xccq304e       number(20,6)      ,/* 本期銷貨成本-制費二 */
xccq304f       number(20,6)      ,/* 本期銷貨成本-制費三 */
xccq304g       number(20,6)      ,/* 本期銷貨成本-製費四 */
xccq304h       number(20,6)      ,/* 本期銷貨成本-製費五 */
xccq305       number(20,6)      ,/* 本期銷退數量 */
xccq306       number(20,6)      ,/* 本期銷退成本 */
xccq306a       number(20,6)      ,/* 本期銷退成本-材料 */
xccq306b       number(20,6)      ,/* 本期銷退成本-人工 */
xccq306c       number(20,6)      ,/* 本期銷退成本-加工 */
xccq306d       number(20,6)      ,/* 本期銷退成本-制費一 */
xccq306e       number(20,6)      ,/* 本期銷退成本-制費二 */
xccq306f       number(20,6)      ,/* 本期銷退成本-制費三 */
xccq306g       number(20,6)      ,/* 本期銷退成本-制費四 */
xccq306h       number(20,6)      ,/* 本期銷退成本-制費五 */
xccq307       number(20,6)      ,/* 本期銷售費用數量 */
xccq308       number(20,6)      ,/* 本期銷售費用成本 */
xccq308a       number(20,6)      ,/* 本期銷售費用成本-材料 */
xccq308b       number(20,6)      ,/* 本期銷售費用成本-人工 */
xccq308c       number(20,6)      ,/* 本期銷售費用成本-加工 */
xccq308d       number(20,6)      ,/* 本期銷售費用成本-製費一 */
xccq308e       number(20,6)      ,/* 本期銷售費用成本-製費二 */
xccq308f       number(20,6)      ,/* 本期銷售費用成本-制費三 */
xccq308g       number(20,6)      ,/* 本期銷售費用成本-製費四 */
xccq308h       number(20,6)      ,/* 本期銷售費用成本-製費五 */
xccq309       number(20,6)      ,/* 本期雜發數量 */
xccq310       number(20,6)      ,/* 本期雜發金額 */
xccq310a       number(20,6)      ,/* 本期雜發金額-材料 */
xccq310b       number(20,6)      ,/* 本期雜發金額-人工 */
xccq310c       number(20,6)      ,/* 本期雜發金額-加工 */
xccq310d       number(20,6)      ,/* 本期雜發金額-製費一 */
xccq310e       number(20,6)      ,/* 本期雜發金額-製費二 */
xccq310f       number(20,6)      ,/* 本期雜發金額-制費三 */
xccq310g       number(20,6)      ,/* 本期雜發金額-製費四 */
xccq310h       number(20,6)      ,/* 本期雜發金額-製費五 */
xccq311       number(20,6)      ,/* 本期盤盈虧數量 */
xccq312       number(20,6)      ,/* 本期盤盈虧金額 */
xccq312a       number(20,6)      ,/* 本期盤盈虧金額-材料 */
xccq312b       number(20,6)      ,/* 本期盤盈虧金額-人工 */
xccq312c       number(20,6)      ,/* 本期盤盈虧金額-加工 */
xccq312d       number(20,6)      ,/* 本期盤盈虧金額-制費一 */
xccq312e       number(20,6)      ,/* 本期盤盈虧金額-製費二 */
xccq312f       number(20,6)      ,/* 本期盤盈虧金額-製費三 */
xccq312g       number(20,6)      ,/* 本期盤盈虧金額-制費四 */
xccq312h       number(20,6)      ,/* 本期盤盈虧金額-製費五 */
xccq313       number(20,6)      ,/* 本期調撥出庫數量 */
xccq314       number(20,6)      ,/* 本期調撥出庫金額 */
xccq314a       number(20,6)      ,/* 本期調撥出庫金額-材料 */
xccq314b       number(20,6)      ,/* 本期調撥出庫金額-人工 */
xccq314c       number(20,6)      ,/* 本期調撥出庫金額-加工 */
xccq314d       number(20,6)      ,/* 本期調撥出庫金額-製費一 */
xccq314e       number(20,6)      ,/* 本期調撥出庫金額-製費二 */
xccq314f       number(20,6)      ,/* 本期調撥出庫金額-製費三 */
xccq314g       number(20,6)      ,/* 本期調撥出庫金額-製費四 */
xccq314h       number(20,6)      ,/* 本期調撥出庫金額-製費五 */
xccq401       number(20,6)      ,/* 本期銷貨收入金額 */
xccq402       number(20,6)      ,/* 本期銷退金額 */
xccq901       number(20,6)      ,/* 期末結存數量 */
xccq902       number(20,6)      ,/* 期末結存金額 */
xccq902a       number(20,6)      ,/* 期末結存金額-材料 */
xccq902b       number(20,6)      ,/* 期末結存金額-人工 */
xccq902c       number(20,6)      ,/* 期末結存金額-加工 */
xccq902d       number(20,6)      ,/* 期末結存金額-制費一 */
xccq902e       number(20,6)      ,/* 期末結存金額-製費二 */
xccq902f       number(20,6)      ,/* 期末結存金額-制費三 */
xccq902g       number(20,6)      ,/* 期末結存金額-製費四 */
xccq902h       number(20,6)      ,/* 期末結存金額-制費五 */
xccq903       number(20,6)      ,/* 期末結存調整金額 */
xccq903a       number(20,6)      ,/* 期末結存調整金額-材料 */
xccq903b       number(20,6)      ,/* 期末結存調整金額-人工 */
xccq903c       number(20,6)      ,/* 期末結存調整金額-加工 */
xccq903d       number(20,6)      ,/* 期末結存調整金額-制費一 */
xccq903e       number(20,6)      ,/* 期末結存調整金額-製費二 */
xccq903f       number(20,6)      ,/* 期末結存調整金額-製費三 */
xccq903g       number(20,6)      ,/* 期末結存調整金額-制費四 */
xccq903h       number(20,6)      ,/* 期末結存調整金額-製費五 */
xccqtime       timestamp(0)      /* 最近成本計算時間 */
);
alter table xccq_t add constraint xccq_pk primary key (xccqent,xccqld,xccqsite,xccq001,xccq002,xccq003,xccq004,xccq005,xccq006,xccq007,xccq008,xccq009,xccq010,xccq011,xccq012) enable validate;

create unique index xccq_pk on xccq_t (xccqent,xccqld,xccqsite,xccq001,xccq002,xccq003,xccq004,xccq005,xccq006,xccq007,xccq008,xccq009,xccq010,xccq011,xccq012);

grant select on xccq_t to tiptop;
grant update on xccq_t to tiptop;
grant delete on xccq_t to tiptop;
grant insert on xccq_t to tiptop;

exit;
