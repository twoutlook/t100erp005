/* 
================================================================================
檔案代號:glao_t
檔案名稱:報表結構設定單身多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table glao_t
(
glaoent       number(5)      ,/* 企業編號 */
glao001       varchar2(10)      ,/* 報表結構編號 */
glao002       number(10,0)      ,/* 序號 */
glao003       varchar2(6)      ,/* 語言別 */
glao004       varchar2(80)      ,/* 列印科目名稱 */
glao005       varchar2(10)      /* 助記碼 */
);
alter table glao_t add constraint glao_pk primary key (glaoent,glao001,glao002,glao003) enable validate;

create unique index glao_pk on glao_t (glaoent,glao001,glao002,glao003);

grant select on glao_t to tiptop;
grant update on glao_t to tiptop;
grant delete on glao_t to tiptop;
grant insert on glao_t to tiptop;

exit;
