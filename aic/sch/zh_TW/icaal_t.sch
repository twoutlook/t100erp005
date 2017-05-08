/* 
================================================================================
檔案代號:icaal_t
檔案名稱:多角貿易流程代碼檔多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table icaal_t
(
icaalent       number(5)      ,/* 企業編號 */
icaal001       varchar2(10)      ,/* 流程代碼 */
icaal002       varchar2(6)      ,/* 語言別 */
icaal003       varchar2(500)      ,/* 說明(簡稱) */
icaal004       varchar2(500)      ,/* 說明(對內全稱) */
icaal005       varchar2(10)      /* 助記碼 */
);
alter table icaal_t add constraint icaal_pk primary key (icaalent,icaal001,icaal002) enable validate;

create unique index icaal_pk on icaal_t (icaalent,icaal001,icaal002);

grant select on icaal_t to tiptop;
grant update on icaal_t to tiptop;
grant delete on icaal_t to tiptop;
grant insert on icaal_t to tiptop;

exit;
