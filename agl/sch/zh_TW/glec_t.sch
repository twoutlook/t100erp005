/* 
================================================================================
檔案代號:glec_t
檔案名稱:合併報表各公司執行階段記錄檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:S
多語系檔案:N
============.========================.==========================================
 */
create table glec_t
(
glecent       number(5)      ,/* 企業代碼 */
glecld       varchar2(5)      ,/* 合併帳別 */
glec001       varchar2(10)      ,/* 上層公司編號 */
glec002       varchar2(5)      ,/* 上層公司帳別 */
glec003       varchar2(10)      ,/* 執行程式 */
glec004       timestamp(0)      ,/* 執行時間 */
glec005       varchar2(1)      /* 執行階段 */
);
alter table glec_t add constraint glec_pk primary key (glecent,glecld,glec001,glec003,glec004,glec005) enable validate;

create unique index glec_pk on glec_t (glecent,glecld,glec001,glec003,glec004,glec005);

grant select on glec_t to tiptop;
grant update on glec_t to tiptop;
grant delete on glec_t to tiptop;
grant insert on glec_t to tiptop;

exit;
