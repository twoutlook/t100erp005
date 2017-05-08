/* 
================================================================================
檔案代號:isacl_t
檔案名稱:發票類型維護多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table isacl_t
(
isaclent       number(5)      ,/* 企業編號 */
isacl001       varchar2(10)      ,/* 交易稅區 */
isacl002       varchar2(10)      ,/* 憑證類型代碼 */
isacl003       varchar2(6)      ,/* 語言別 */
isacl004       varchar2(500)      /* 說明 */
);
alter table isacl_t add constraint isacl_pk primary key (isaclent,isacl001,isacl002,isacl003) enable validate;

create unique index isacl_pk on isacl_t (isaclent,isacl001,isacl002,isacl003);

grant select on isacl_t to tiptop;
grant update on isacl_t to tiptop;
grant delete on isacl_t to tiptop;
grant insert on isacl_t to tiptop;

exit;
