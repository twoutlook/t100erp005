/* 
================================================================================
檔案代號:fmaql_t
檔案名稱:債券名稱多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:Y
============.========================.==========================================
 */
create table fmaql_t
(
fmaqlent       number(5)      ,/* 企业代码 */
fmaql001       varchar2(10)      ,/* 融資合同編號 */
fmaql002       varchar2(10)      ,/* 債券編號 */
fmaql003       varchar2(6)      ,/* 語言別 */
fmaql004       varchar2(500)      ,/* 說明 */
fmaql005       varchar2(500)      /* 助記碼 */
);
alter table fmaql_t add constraint fmaql_pk primary key (fmaqlent,fmaql001,fmaql002,fmaql003) enable validate;

create unique index fmaql_pk on fmaql_t (fmaqlent,fmaql001,fmaql002,fmaql003);

grant select on fmaql_t to tiptop;
grant update on fmaql_t to tiptop;
grant delete on fmaql_t to tiptop;
grant insert on fmaql_t to tiptop;

exit;
