/* 
================================================================================
檔案代號:xcaul_t
檔案名稱:成本次要素檔多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table xcaul_t
(
xcaulent       number(5)      ,/* 企業編號 */
xcaul001       varchar2(80)      ,/* 成本次要素編號 */
xcaul002       varchar2(6)      ,/* 語言別 */
xcaul003       varchar2(500)      ,/* 說明 */
xcaul004       varchar2(10)      /* 助記碼 */
);
alter table xcaul_t add constraint xcaul_pk primary key (xcaulent,xcaul001,xcaul002) enable validate;

create unique index xcaul_pk on xcaul_t (xcaulent,xcaul001,xcaul002);

grant select on xcaul_t to tiptop;
grant update on xcaul_t to tiptop;
grant delete on xcaul_t to tiptop;
grant insert on xcaul_t to tiptop;

exit;
