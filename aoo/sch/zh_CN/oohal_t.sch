/* 
================================================================================
檔案代號:oohal_t
檔案名稱:控制組多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:Y
============.========================.==========================================
 */
create table oohal_t
(
oohalent       number(5)      ,/* 企業編號 */
oohal001       varchar2(10)      ,/* 控制組編號 */
oohal002       varchar2(6)      ,/* 語言別 */
oohal003       varchar2(500)      ,/* 說明 */
oohal004       varchar2(10)      ,/* 助記碼 */
oohal005       varchar2(255)      /* 備註 */
);
alter table oohal_t add constraint oohal_pk primary key (oohalent,oohal001,oohal002) enable validate;

create  index oohal_idx on oohal_t (oohal004);
create unique index oohal_pk on oohal_t (oohalent,oohal001,oohal002);

grant select on oohal_t to tiptop;
grant update on oohal_t to tiptop;
grant delete on oohal_t to tiptop;
grant insert on oohal_t to tiptop;

exit;
