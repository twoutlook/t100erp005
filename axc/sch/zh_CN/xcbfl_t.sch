/* 
================================================================================
檔案代號:xcbfl_t
檔案名稱:成本域範圍設定檔多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table xcbfl_t
(
xcbflent       number(5)      ,/* 企業編號 */
xcbflcomp       varchar2(10)      ,/* 法人組織 */
xcbfl001       varchar2(10)      ,/* 成本域編號 */
xcbfl002       varchar2(6)      ,/* 語言別 */
xcbfl003       varchar2(500)      ,/* 說明 */
xcbfl004       varchar2(10)      /* 助記碼 */
);
alter table xcbfl_t add constraint xcbfl_pk primary key (xcbflent,xcbflcomp,xcbfl001,xcbfl002) enable validate;

create unique index xcbfl_pk on xcbfl_t (xcbflent,xcbflcomp,xcbfl001,xcbfl002);

grant select on xcbfl_t to tiptop;
grant update on xcbfl_t to tiptop;
grant delete on xcbfl_t to tiptop;
grant insert on xcbfl_t to tiptop;

exit;
