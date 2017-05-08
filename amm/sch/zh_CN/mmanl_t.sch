/* 
================================================================================
檔案代號:mmanl_t
檔案名稱:會員卡種資料檔多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table mmanl_t
(
mmanlent       number(5)      ,/* 企業編號 */
mmanl001       varchar2(10)      ,/* 卡種編號 */
mmanl002       varchar2(6)      ,/* 語言別 */
mmanl003       varchar2(500)      ,/* 說明 */
mmanl004       varchar2(10)      /* 助記碼 */
);
alter table mmanl_t add constraint mmanl_pk primary key (mmanlent,mmanl001,mmanl002) enable validate;

create  index mmanl_01 on mmanl_t (mmanl004);
create unique index mmanl_pk on mmanl_t (mmanlent,mmanl001,mmanl002);

grant select on mmanl_t to tiptop;
grant update on mmanl_t to tiptop;
grant delete on mmanl_t to tiptop;
grant insert on mmanl_t to tiptop;

exit;
