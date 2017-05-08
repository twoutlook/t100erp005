/* 
================================================================================
檔案代號:faabs_t
檔案名稱:固定資產組織結構檔提速檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:V
多語系檔案:N
============.========================.==========================================
 */
create table faabs_t
(
faabsent       number(5)      ,/* 企業編號 */
faabs001       varchar2(1)      ,/* 組織類型 */
faabs002       varchar2(10)      ,/* 資產中心 */
faabs003       number(5,0)      ,/* 版本 */
faabs004       varchar2(10)      ,/* 組織編號 */
faabs005       varchar2(40)      ,/* 提速值 */
faabs006       number(5,0)      /* 階層 */
);
alter table faabs_t add constraint faabs_pk primary key (faabsent,faabs001,faabs002,faabs003,faabs004,faabs005) enable validate;

create unique index faabs_pk on faabs_t (faabsent,faabs001,faabs002,faabs003,faabs004,faabs005);

grant select on faabs_t to tiptop;
grant update on faabs_t to tiptop;
grant delete on faabs_t to tiptop;
grant insert on faabs_t to tiptop;

exit;
