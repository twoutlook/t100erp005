/* 
================================================================================
檔案代號:isanl_t
檔案名稱:稅別公式基本資料檔多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table isanl_t
(
isanlent       number(5)      ,/* 企業編號 */
isanl001       varchar2(10)      ,/* 交易稅區 */
isanl002       varchar2(10)      ,/* 公式代碼 */
isanl003       varchar2(6)      ,/* 語言別 */
isanl004       varchar2(500)      /* 說明 */
);
alter table isanl_t add constraint isanl_pk primary key (isanlent,isanl001,isanl002,isanl003) enable validate;

create unique index isanl_pk on isanl_t (isanlent,isanl001,isanl002,isanl003);

grant select on isanl_t to tiptop;
grant update on isanl_t to tiptop;
grant delete on isanl_t to tiptop;
grant insert on isanl_t to tiptop;

exit;
