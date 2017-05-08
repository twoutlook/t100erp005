/* 
================================================================================
檔案代號:xcdt_t
檔案名稱:在制工藝成本次要素轉出明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:S
多語系檔案:N
============.========================.==========================================
 */
create table xcdt_t
(
xcdtent       number(5)      ,/* 企業編號 */
xcdtcomp       varchar2(10)      ,/* 法人組織 */
xcdtld       varchar2(5)      ,/* 賬套 */
xcdt001       varchar2(1)      ,/* 賬套本位幣順序 */
xcdt002       varchar2(30)      ,/* 成本域 */
xcdt003       varchar2(10)      ,/* 成本計算類型 */
xcdt004       number(5,0)      ,/* 年度 */
xcdt005       number(5,0)      ,/* 期別 */
xcdt006       varchar2(20)      ,/* 工單編號/在制代號 */
xcdt007       varchar2(10)      ,/* 作業編號 */
xcdt008       varchar2(10)      ,/* 製程序 */
xcdt009       varchar2(40)      ,/* 元件料號 */
xcdt010       varchar2(256)      ,/* 特性 */
xcdt011       varchar2(30)      ,/* 批號 */
xcdt012       varchar2(40)      ,/* 次要素 */
xcdt013       varchar2(10)      ,/* 下個作業編號 */
xcdt014       varchar2(10)      ,/* 下個製程序 */
xcdt301       number(20,6)      ,/* 本期轉出數量 */
xcdt302       number(20,6)      ,/* 本期轉出金額 */
xcdttime       timestamp(0)      /* 最近成本計算時間 */
);
alter table xcdt_t add constraint xcdt_pk primary key (xcdtent,xcdtld,xcdt001,xcdt002,xcdt003,xcdt004,xcdt005,xcdt006,xcdt007,xcdt008,xcdt009,xcdt010,xcdt011,xcdt012,xcdt013,xcdt014) enable validate;

create unique index xcdt_pk on xcdt_t (xcdtent,xcdtld,xcdt001,xcdt002,xcdt003,xcdt004,xcdt005,xcdt006,xcdt007,xcdt008,xcdt009,xcdt010,xcdt011,xcdt012,xcdt013,xcdt014);

grant select on xcdt_t to tiptop;
grant update on xcdt_t to tiptop;
grant delete on xcdt_t to tiptop;
grant insert on xcdt_t to tiptop;

exit;
