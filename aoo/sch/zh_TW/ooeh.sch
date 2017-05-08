/* 
================================================================================
檔案代號:ooeh
檔案名稱:據點級資料集團控制設定檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table ooeh
(
ooehent       number(5)      ,/* 企業代碼 */
ooeh001       varchar2(10)      ,/* 資料類型 */
ooeh002       varchar2(20)      /* 欄位代號 */
);
alter table ooeh add constraint ooeh_pk primary key (ooehent,ooeh001,ooehent,ooeh001,ooehent,ooeh001,ooehent,ooeh001,ooeh002) enable validate;


grant select on ooeh to tiptop;
grant update on ooeh to tiptop;
grant delete on ooeh to tiptop;
grant insert on ooeh to tiptop;

exit;
