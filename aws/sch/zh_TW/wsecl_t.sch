/* 
================================================================================
檔案代號:wsecl_t
檔案名稱:整合產品資料表多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table wsecl_t
(
wsecl001       varchar2(10)      ,/* 產品別 */
wsecl002       varchar2(6)      ,/* 語言別 */
wsecl003       varchar2(500)      ,/* 說明 */
wsecl004       varchar2(10)      /* 助記碼 */
);
alter table wsecl_t add constraint wsecl_pk primary key (wsecl001,wsecl002) enable validate;

create unique index wsecl_pk on wsecl_t (wsecl001,wsecl002);

grant select on wsecl_t to tiptop;
grant update on wsecl_t to tiptop;
grant delete on wsecl_t to tiptop;
grant insert on wsecl_t to tiptop;

exit;
