/* 
================================================================================
檔案代號:dzyg_t
檔案名稱:Patch包歷程記錄
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table dzyg_t
(
dzyg001       varchar2(80)      ,/* 匯入包編號 */
dzyg002       varchar2(1)      ,/* 完成table alter否 */
dzyg003       varchar2(1)      ,/* 完成dmp否 */
dzyg004       varchar2(1)      ,/* 完成patch資料合併否 */
dzyg005       varchar2(1)      ,/* 完成平台工具否 */
dzyg006       varchar2(1)      ,/* 完成patch匯入否 */
dzyg007       timestamp(0)      ,/* patch起始時間 */
dzyg008       timestamp(0)      /* patch結束時間 */
);
alter table dzyg_t add constraint dzyg_pk primary key (dzyg001) enable validate;

create unique index dzyg_pk on dzyg_t (dzyg001);

grant select on dzyg_t to tiptop;
grant update on dzyg_t to tiptop;
grant delete on dzyg_t to tiptop;
grant insert on dzyg_t to tiptop;

exit;
