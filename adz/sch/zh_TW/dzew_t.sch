/* 
================================================================================
檔案代號:dzew_t
檔案名稱:索引/鍵快照檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table dzew_t
(
dzewstus       varchar2(10)      ,/* 狀態碼 */
dzew001       varchar2(15)      ,/* Table代號 */
dzew002       varchar2(20)      ,/* 流水號 */
dzew003       varchar2(20)      ,/* 資料類別 */
dzew004       varchar2(20)      ,/* 索引/鍵代號 */
dzew005       varchar2(20)      ,/* 索引/鍵形式 */
dzew006       varchar2(500)      ,/* 索引/鍵欄位 */
dzew007       varchar2(15)      ,/* 外來鍵表格 */
dzew008       varchar2(500)      ,/* 外來鍵欄位 */
dzew009       varchar2(20)      ,/* 前流水號 */
dzew010       varchar2(20)      ,/* ALM版本號 */
dzewownid       varchar2(20)      ,/* 資料所有者 */
dzewowndp       varchar2(10)      ,/* 資料所屬部門 */
dzewcrtid       varchar2(20)      ,/* 資料建立者 */
dzewcrtdp       varchar2(10)      ,/* 資料建立部門 */
dzewcrtdt       timestamp(0)      ,/* 資料創建日 */
dzewmodid       varchar2(20)      ,/* 資料修改者 */
dzewmoddt       timestamp(0)      ,/* 最近修改日 */
dzewcnfid       varchar2(20)      ,/* 資料確認者 */
dzewcnfdt       timestamp(0)      ,/* 資料確認日 */
dzew011       varchar2(40)      ,/* ALM需求單號 */
dzew012       varchar2(1)      ,/* Patch標示 */
dzew013       varchar2(1)      ,/* 原始Patch標示 */
dzew014       varchar2(1)      /* 出貨標示 */
);
alter table dzew_t add constraint dzew_pk primary key (dzew001,dzew002,dzew003,dzew004) enable validate;

create unique index dzew_pk on dzew_t (dzew001,dzew002,dzew003,dzew004);

grant select on dzew_t to tiptop;
grant update on dzew_t to tiptop;
grant delete on dzew_t to tiptop;
grant insert on dzew_t to tiptop;

exit;
