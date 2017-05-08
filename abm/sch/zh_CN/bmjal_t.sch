/* 
================================================================================
檔案代號:bmjal_t
檔案名稱:ECR模板維護單頭檔多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table bmjal_t
(
bmjalent       number(5)      ,/* 企業代碼 */
bmjal001       varchar2(10)      ,/* 模板編號 */
bmjal002       varchar2(6)      ,/* 語言別 */
bmjal003       varchar2(500)      ,/* 說明 */
bmjal004       varchar2(10)      /* 助記碼 */
);
alter table bmjal_t add constraint bmjal_pk primary key (bmjalent,bmjal001,bmjal002) enable validate;

create unique index bmjal_pk on bmjal_t (bmjalent,bmjal001,bmjal002);

grant select on bmjal_t to tiptop;
grant update on bmjal_t to tiptop;
grant delete on bmjal_t to tiptop;
grant insert on bmjal_t to tiptop;

exit;
