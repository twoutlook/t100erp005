/* 
================================================================================
檔案代號:xcawl_t
檔案名稱:成本次要素與資源關係設置檔多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table xcawl_t
(
xcawlent       number(5)      ,/* 企業編號 */
xcawl001       varchar2(10)      ,/* 資源編號 */
xcawl002       varchar2(6)      ,/* 語言別 */
xcawl003       varchar2(500)      ,/* 說明 */
xcawl004       varchar2(10)      /* 助記碼 */
);
alter table xcawl_t add constraint xcawl_pk primary key (xcawlent,xcawl001,xcawl002) enable validate;

create unique index xcawl_pk on xcawl_t (xcawlent,xcawl001,xcawl002);

grant select on xcawl_t to tiptop;
grant update on xcawl_t to tiptop;
grant delete on xcawl_t to tiptop;
grant insert on xcawl_t to tiptop;

exit;
