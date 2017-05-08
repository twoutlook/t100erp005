/* 
================================================================================
檔案代號:xccx_t
檔案名稱:工藝在製成本本期調整檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table xccx_t
(
xccxent       number(5)      ,/* 企業編號 */
xccxld       varchar2(5)      ,/* 帳套 */
xccxcomp       varchar2(10)      ,/* 法人組織 */
xccx001       varchar2(1)      ,/* 帳套本位幣順序 */
xccx002       varchar2(30)      ,/* 成本域 */
xccx003       varchar2(10)      ,/* 成本計算類型 */
xccx004       number(5,0)      ,/* 年度 */
xccx005       number(5,0)      ,/* 期別 */
xccx006       varchar2(20)      ,/* 調整單號 */
xccx007       varchar2(20)      ,/* 工單編號 */
xccx008       varchar2(10)      ,/* 作業編號 */
xccx009       varchar2(1)      ,/* 作業序 */
xccx010       varchar2(1)      ,/* 調整類型 */
xccx011       varchar2(80)      ,/* 調整說明 */
xccx101       number(20,6)      ,/* 當月調整數量 */
xccx102       number(20,6)      ,/* 當月調整金額 */
xccx102a       number(20,6)      ,/* 當月調整金額-材料 */
xccx102b       number(20,6)      ,/* 當月調整金額-人工 */
xccx102c       number(20,6)      ,/* 當月調整金額-委外加工 */
xccx102d       number(20,6)      ,/* 當月調整金額-制費一 */
xccx102e       number(20,6)      ,/* 當月調整金額-制費二 */
xccx102f       number(20,6)      ,/* 當月調整金額-制費三 */
xccx102g       number(20,6)      ,/* 當月調整金額-制費四 */
xccx102h       number(20,6)      /* 當月調整金額-制費五 */
);
alter table xccx_t add constraint xccx_pk primary key (xccxent,xccxld,xccx001,xccx002,xccx003,xccx004,xccx005,xccx006,xccx007,xccx008,xccx009) enable validate;

create unique index xccx_pk on xccx_t (xccxent,xccxld,xccx001,xccx002,xccx003,xccx004,xccx005,xccx006,xccx007,xccx008,xccx009);

grant select on xccx_t to tiptop;
grant update on xccx_t to tiptop;
grant delete on xccx_t to tiptop;
grant insert on xccx_t to tiptop;

exit;
