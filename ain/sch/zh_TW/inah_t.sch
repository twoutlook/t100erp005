/* 
================================================================================
檔案代號:inah_t
檔案名稱:參考單位/庫存包裝明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:S
多語系檔案:N
============.========================.==========================================
 */
create table inah_t
(
inahent       number(5)      ,/* 企業編號 */
inahsite       varchar2(10)      ,/* 營運據點 */
inah001       varchar2(40)      ,/* 料件編號 */
inah002       varchar2(256)      ,/* 產品特徵 */
inah003       varchar2(30)      ,/* 庫存管理特徵 */
inah004       varchar2(10)      ,/* 庫位編號 */
inah005       varchar2(10)      ,/* 儲位編號 */
inah006       varchar2(30)      ,/* 批號 */
inah007       varchar2(40)      ,/* 參考單位/包裝編號 */
inah008       varchar2(1)      ,/* 庫存類型 */
inah009       number(20,6)      ,/* 帳面庫存數量 */
inah010       number(20,6)      ,/* 實際庫存數量 */
inah011       varchar2(256)      /* Tag二進位碼 */
);
alter table inah_t add constraint inah_pk primary key (inahent,inahsite,inah001,inah002,inah003,inah004,inah005,inah006,inah007) enable validate;

create  index inah_01 on inah_t (inah011);
create unique index inah_pk on inah_t (inahent,inahsite,inah001,inah002,inah003,inah004,inah005,inah006,inah007);

grant select on inah_t to tiptop;
grant update on inah_t to tiptop;
grant delete on inah_t to tiptop;
grant insert on inah_t to tiptop;

exit;
