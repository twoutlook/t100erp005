/* 
================================================================================
檔案代號:gzdg_t
檔案名稱:程式與應用表格功能分析表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table gzdg_t
(
gzdg001       varchar2(20)      ,/* 程式編號 */
gzdg002       varchar2(15)      ,/* 表格編號 */
gzdg003       varchar2(1)      ,/* 功能類別 */
gzdg004       timestamp(0)      ,/* 更新時間 */
gzdg005       varchar2(1)      /* 更新暫存註記 */
);
alter table gzdg_t add constraint gzdg_pk primary key (gzdg001,gzdg002,gzdg003) enable validate;

create unique index gzdg_pk on gzdg_t (gzdg001,gzdg002,gzdg003);

grant select on gzdg_t to tiptop;
grant update on gzdg_t to tiptop;
grant delete on gzdg_t to tiptop;
grant insert on gzdg_t to tiptop;

exit;
