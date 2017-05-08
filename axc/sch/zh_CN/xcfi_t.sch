/* 
================================================================================
檔案代號:xcfi_t
檔案名稱:LCM存貨成本計算逆推明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table xcfi_t
(
xcfient       number(5)      ,/* 企業編號 */
xcficomp       varchar2(10)      ,/* 法人組織 */
xcfild       varchar2(5)      ,/* 帳套 */
xcfi001       varchar2(1)      ,/* 帳套本位幣順序 */
xcfi002       varchar2(30)      ,/* 成本域 */
xcfi003       varchar2(10)      ,/* 成本計算類型 */
xcfi004       number(5,0)      ,/* 年度 */
xcfi005       number(5,0)      ,/* 期別 */
xcfi006       varchar2(40)      ,/* 料件 */
xcfi007       varchar2(256)      ,/* 特性 */
xcfi008       varchar2(30)      ,/* 批號 */
xcfi009       varchar2(40)      ,/* 逆推最終成品料號 */
xcfi010       number(20,6)      ,/* 單位用量 */
xcfi011       number(20,6)      ,/* 逆推成品淨變現單價 */
xcfi012       number(20,6)      ,/* 逆推成品生產入庫量 */
xcfi013       number(20,6)      ,/* 逆推成品銷售出貨量 */
xcfi014       date      ,/* 計算起始日期 */
xcfi015       date      /* 計算截至日期 */
);
alter table xcfi_t add constraint xcfi_pk primary key (xcfient,xcfild,xcfi001,xcfi002,xcfi003,xcfi004,xcfi005,xcfi006,xcfi007,xcfi008,xcfi009) enable validate;

create unique index xcfi_pk on xcfi_t (xcfient,xcfild,xcfi001,xcfi002,xcfi003,xcfi004,xcfi005,xcfi006,xcfi007,xcfi008,xcfi009);

grant select on xcfi_t to tiptop;
grant update on xcfi_t to tiptop;
grant delete on xcfi_t to tiptop;
grant insert on xcfi_t to tiptop;

exit;
