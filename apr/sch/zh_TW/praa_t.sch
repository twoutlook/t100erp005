/* 
================================================================================
檔案代號:praa_t
檔案名稱:促銷策略-優先順序基本資料表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table praa_t
(
praaent       number(5)      ,/* 企業編號 */
praaunit       varchar2(10)      ,/* 應用組織 */
praa001       varchar2(10)      ,/* 促銷類型 */
praa002       number(5,0)      ,/* 優先級 */
praastus       varchar2(10)      ,/* 狀態碼 */
praa000       varchar2(10)      /* 優先類型 */
);
alter table praa_t add constraint praa_pk primary key (praaent,praa001) enable validate;

create unique index praa_pk on praa_t (praaent,praa001);

grant select on praa_t to tiptop;
grant update on praa_t to tiptop;
grant delete on praa_t to tiptop;
grant insert on praa_t to tiptop;

exit;
