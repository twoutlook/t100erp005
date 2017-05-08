/* 
================================================================================
檔案代號:imefl_t
檔案名稱:規則化品名節點多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table imefl_t
(
imeflent       number(5)      ,/* 企業編號 */
imefl001       varchar2(10)      ,/* 品名種類 */
imefl002       varchar2(10)      ,/* 節點編號 */
imefl003       varchar2(40)      ,/* 選項值 */
imefl004       varchar2(6)      ,/* 語言別 */
imefl005       varchar2(500)      ,/* 說明 */
imefl006       varchar2(10)      /* 助記碼 */
);
alter table imefl_t add constraint imefl_pk primary key (imeflent,imefl001,imefl002,imefl003,imefl004) enable validate;

create  index imefl_01 on imefl_t (imefl006);
create unique index imefl_pk on imefl_t (imeflent,imefl001,imefl002,imefl003,imefl004);

grant select on imefl_t to tiptop;
grant update on imefl_t to tiptop;
grant delete on imefl_t to tiptop;
grant insert on imefl_t to tiptop;

exit;
