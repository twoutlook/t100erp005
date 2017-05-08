/* 
================================================================================
檔案代號:stael_t
檔案名稱:費用編號基本資料檔多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table stael_t
(
staelent       number(5)      ,/* 企業編號 */
stael001       varchar2(10)      ,/* 費用編號 */
stael002       varchar2(6)      ,/* 語言別 */
stael003       varchar2(500)      ,/* 說明 */
stael004       varchar2(10)      /* 助記碼 */
);
alter table stael_t add constraint stael_pk primary key (staelent,stael001,stael002) enable validate;

create  index stael_01 on stael_t (stael004);
create unique index stael_pk on stael_t (staelent,stael001,stael002);

grant select on stael_t to tiptop;
grant update on stael_t to tiptop;
grant delete on stael_t to tiptop;
grant insert on stael_t to tiptop;

exit;
