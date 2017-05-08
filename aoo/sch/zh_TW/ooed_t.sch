/* 
================================================================================
檔案代號:ooed_t
檔案名稱:組織結構調整計劃結存檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:S
多語系檔案:N
============.========================.==========================================
 */
create table ooed_t
(
ooedent       number(5)      ,/* 企業編號 */
ooed001       varchar2(10)      ,/* 組織類型 */
ooed002       varchar2(10)      ,/* 最上層組織 */
ooed003       varchar2(10)      ,/* 版本 */
ooed004       varchar2(10)      ,/* 組織編號 */
ooed005       varchar2(10)      ,/* 上級組織編號 */
ooed006       date      ,/* 生效日期 */
ooed007       date      ,/* 失效日期 */
ooed008       varchar2(10)      /* 申請編號 */
);
alter table ooed_t add constraint ooed_pk primary key (ooedent,ooed001,ooed002,ooed003,ooed004,ooed005) enable validate;

create unique index ooed_pk on ooed_t (ooedent,ooed001,ooed002,ooed003,ooed004,ooed005);

grant select on ooed_t to tiptop;
grant update on ooed_t to tiptop;
grant delete on ooed_t to tiptop;
grant insert on ooed_t to tiptop;

exit;
