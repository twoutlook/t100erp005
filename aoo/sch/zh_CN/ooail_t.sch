/* 
================================================================================
檔案代號:ooail_t
檔案名稱:幣別檔多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table ooail_t
(
ooailent       number(5)      ,/* 企業編號 */
ooail001       varchar2(10)      ,/* 幣別 */
ooail002       varchar2(6)      ,/* 多語言 */
ooail003       varchar2(500)      ,/* 說明 */
ooail004       varchar2(10)      /* 助記碼 */
);
alter table ooail_t add constraint ooail_pk primary key (ooailent,ooail001,ooail002) enable validate;

create unique index ooail_pk on ooail_t (ooailent,ooail001,ooail002);

grant select on ooail_t to tiptop;
grant update on ooail_t to tiptop;
grant delete on ooail_t to tiptop;
grant insert on ooail_t to tiptop;

exit;
