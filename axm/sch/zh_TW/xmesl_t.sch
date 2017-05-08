/* 
================================================================================
檔案代號:xmesl_t
檔案名稱:銷售估價範本單頭檔多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table xmesl_t
(
xmeslent       number(5)      ,/* 企業編號 */
xmesldocno       varchar2(20)      ,/* 範本料號 */
xmesl002       varchar2(6)      ,/* 語言別 */
xmesl003       varchar2(500)      ,/* 說明 */
xmesl004       varchar2(10)      /* 助記碼 */
);
alter table xmesl_t add constraint xmesl_pk primary key (xmeslent,xmesldocno,xmesl002) enable validate;

create unique index xmesl_pk on xmesl_t (xmeslent,xmesldocno,xmesl002);

grant select on xmesl_t to tiptop;
grant update on xmesl_t to tiptop;
grant delete on xmesl_t to tiptop;
grant insert on xmesl_t to tiptop;

exit;
