/* 
================================================================================
檔案代號:xcah_t
檔案名稱:標準成本_元件組成明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table xcah_t
(
xcahent       number(5)      ,/* 企業編號 */
xcahsite       varchar2(10)      ,/* 營運據點 */
xcahcomp       varchar2(10)      ,/* 法人組織 */
xcah001       varchar2(80)      ,/* 標準成本分類 */
xcah002       date      ,/* 生效日期 */
xcah003       date      ,/* 失效日期 */
xcah004       varchar2(80)      ,/* 主件料號 */
xcahseq       number(10,0)      ,/* 項次 */
xcah010       varchar2(30)      ,/* 版本 */
xcah011       varchar2(10)      ,/* 幣別 */
xcah012       varchar2(10)      ,/* 主件來源碼 */
xcah013       varchar2(10)      ,/* 主件單位 */
xcah020       number(10,0)      ,/* 階數 */
xcah021       number(10,0)      ,/* BOM序號 */
xcah022       varchar2(40)      ,/* 元件料號 */
xcah023       varchar2(10)      ,/* 元件來源碼 */
xcah024       varchar2(10)      ,/* 元件單位 */
xcah025       number(20,6)      ,/* 本階主件底數 */
xcah026       number(20,6)      ,/* 本階元件組成用量 */
xcah027       number(20,6)      ,/* 本階元件損耗率 */
xcah028       number(10,0)      ,/* 上階項次 */
xcah030       number(20,6)      ,/* 單位成本 */
xcah030a       number(20,6)      ,/* 單位成本-材料 */
xcah030b       number(20,6)      ,/* 單位成本-人工 */
xcah030c       number(20,6)      ,/* 單位成本-委外 */
xcah030d       number(20,6)      ,/* 單位成本-制費一 */
xcah030e       number(20,6)      ,/* 單位成本-制費二 */
xcah030f       number(20,6)      ,/* 單位成本-制費三 */
xcah030g       number(20,6)      ,/* 單位成本-制費四 */
xcah030h       number(20,6)      ,/* 單位成本-制費五 */
xcah031       number(20,6)      ,/* 成本金額 */
xcah031a       number(20,6)      ,/* 成本金額-材料 */
xcah031b       number(20,6)      ,/* 成本金額-人工 */
xcah031c       number(20,6)      ,/* 成本金額-委外 */
xcah031d       number(20,6)      ,/* 成本金額-制費一 */
xcah031e       number(20,6)      ,/* 成本金額-制費二 */
xcah031f       number(20,6)      ,/* 成本金額-制費三 */
xcah031g       number(20,6)      ,/* 成本金額-制費四 */
xcah031h       number(20,6)      ,/* 成本金額-制費五 */
xcah040       varchar2(40)      ,/* 本階主件料號 */
xcah041       varchar2(10)      ,/* 本階主件類別碼 */
xcah042       number(20,6)      ,/* 最終主件底數 */
xcah043       number(20,6)      ,/* 本階主件組成用量 */
xcah044       number(20,6)      ,/* 本階主件損耗率 */
xcah101       varchar2(10)      ,/* 歸屬主成本要素 */
xcah102       varchar2(10)      ,/* 歸屬次成本要素 */
xcahownid       varchar2(20)      ,/* 資料所有者 */
xcahowndp       varchar2(10)      ,/* 資料所屬部門 */
xcahcrtid       varchar2(20)      ,/* 資料建立者 */
xcahcrtdp       varchar2(10)      ,/* 資料建立部門 */
xcahcrtdt       timestamp(0)      ,/* 資料創建日 */
xcahmodid       varchar2(20)      ,/* 資料修改者 */
xcahmoddt       timestamp(0)      ,/* 最近修改日 */
xcahstus       varchar2(10)      /* 狀態碼 */
);
alter table xcah_t add constraint xcah_pk primary key (xcahent,xcahsite,xcah001,xcah002,xcah004,xcahseq) enable validate;

create unique index xcah_pk on xcah_t (xcahent,xcahsite,xcah001,xcah002,xcah004,xcahseq);

grant select on xcah_t to tiptop;
grant update on xcah_t to tiptop;
grant delete on xcah_t to tiptop;
grant insert on xcah_t to tiptop;

exit;
