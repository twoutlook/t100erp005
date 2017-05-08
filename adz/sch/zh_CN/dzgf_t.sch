/* 
================================================================================
檔案代號:dzgf_t
檔案名稱:報表元件設計-資料模型篩選條件式明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table dzgf_t
(
dzgf001       varchar2(20)      ,/* 報表元件代號 */
dzgf002       number(10)      ,/* 版次 */
dzgf003       number(5,0)      ,/* 序號 */
dzgf004       varchar2(5)      ,/* ( */
dzgf005       varchar2(15)      ,/* Table編號 */
dzgf006       varchar2(20)      ,/* 欄位編號 */
dzgf007       varchar2(2)      ,/* 運算子 */
dzgf008       varchar2(500)      ,/* 值 */
dzgf009       varchar2(5)      ,/* ) */
dzgf010       varchar2(1)      ,/* AND/OR */
dzgf011       varchar2(40)      ,/* 客戶代號 */
dzgf012       varchar2(1)      /* 客製 */
);
alter table dzgf_t add constraint dzgf_pk primary key (dzgf001,dzgf002,dzgf003,dzgf012) enable validate;

create unique index dzgf_pk on dzgf_t (dzgf001,dzgf002,dzgf003,dzgf012);

grant select on dzgf_t to tiptop;
grant update on dzgf_t to tiptop;
grant delete on dzgf_t to tiptop;
grant insert on dzgf_t to tiptop;

exit;
