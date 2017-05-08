/* 
================================================================================
檔案代號:oobml_t
檔案名稱:單據流程設定單頭檔多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table oobml_t
(
oobmlent       number(5)      ,/* 企業編號 */
oobml001       varchar2(10)      ,/* 流程編號 */
oobml002       varchar2(6)      ,/* 多語言 */
oobml003       varchar2(500)      ,/* 說明 */
oobml004       varchar2(10)      /* 助記碼 */
);
alter table oobml_t add constraint oobml_pk primary key (oobmlent,oobml001,oobml002) enable validate;

create unique index oobml_pk on oobml_t (oobmlent,oobml001,oobml002);

grant select on oobml_t to tiptop;
grant update on oobml_t to tiptop;
grant delete on oobml_t to tiptop;
grant insert on oobml_t to tiptop;

exit;
