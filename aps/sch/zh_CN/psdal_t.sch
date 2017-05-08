/* 
================================================================================
檔案代號:psdal_t
檔案名稱:供給法則檔多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:Y
============.========================.==========================================
 */
create table psdal_t
(
psdalent       number(5)      ,/* 企業編號 */
psdalsite       varchar2(10)      ,/* 營運據點 */
psdal001       varchar2(10)      ,/* 供給法則代號 */
psdal002       varchar2(6)      ,/* 語言別 */
psdal003       varchar2(500)      ,/* 說明 */
psdal004       varchar2(10)      /* 助記碼 */
);
alter table psdal_t add constraint psdal_pk primary key (psdalent,psdalsite,psdal001,psdal002) enable validate;

create unique index psdal_pk on psdal_t (psdalent,psdalsite,psdal001,psdal002);

grant select on psdal_t to tiptop;
grant update on psdal_t to tiptop;
grant delete on psdal_t to tiptop;
grant insert on psdal_t to tiptop;

exit;
