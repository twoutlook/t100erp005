/* 
================================================================================
檔案代號:gzgk_t
檔案名稱:報表表頭設定單身檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table gzgk_t
(
gzgk001       varchar2(10)      ,/* 表頭代號 */
gzgk002       varchar2(6)      ,/* 語言別 */
gzgk003       number(5,0)      ,/* 行序 */
gzgk004       number(5,0)      ,/* 欄序 */
gzgk005       varchar2(20)      ,/* 合併 */
gzgk006       varchar2(10)      ,/* 顯示內容 */
gzgk007       varchar2(20)      ,/* 字型 */
gzgk008       number(5)      ,/* 字型大小 */
gzgk009       varchar2(1)      ,/* 位置 */
gzgk010       varchar2(1)      ,/* 粗體 */
gzgk011       varchar2(1)      ,/* 斜體 */
gzgk012       varchar2(20)      ,/* 顏色 */
gzgk013       varchar2(20)      ,/* 背景顏色 */
gzgk014       varchar2(1)      /* 報表區段 */
);
alter table gzgk_t add constraint gzgk_pk primary key (gzgk001,gzgk002,gzgk003,gzgk004,gzgk014) enable validate;

create unique index gzgk_pk on gzgk_t (gzgk001,gzgk002,gzgk003,gzgk004,gzgk014);

grant select on gzgk_t to tiptop;
grant update on gzgk_t to tiptop;
grant delete on gzgk_t to tiptop;
grant insert on gzgk_t to tiptop;

exit;
