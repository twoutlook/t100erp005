/* 
================================================================================
檔案代號:ooej_t
檔案名稱:當前組織結構檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:S
多語系檔案:N
============.========================.==========================================
 */
create table ooej_t
(
ooejent       number(5)      ,/* 企業代碼 */
ooej001       varchar2(10)      ,/* 組織類型 */
ooej002       varchar2(10)      ,/* 最上層組織 */
ooej003       varchar2(10)      ,/* 版本 */
ooej004       varchar2(10)      ,/* 組織編號 */
ooej005       varchar2(10)      ,/* 上級組織編號 */
ooej006       date      ,/* 生效日期 */
ooej007       date      /* 失效日期 */
);
alter table ooej_t add constraint ooej_pk primary key (ooejent,ooej001,ooej002,ooej004,ooej005) enable validate;

create unique index ooej_pk on ooej_t (ooejent,ooej001,ooej002,ooej004,ooej005);

grant select on ooej_t to tiptop;
grant update on ooej_t to tiptop;
grant delete on ooej_t to tiptop;
grant insert on ooej_t to tiptop;

exit;
