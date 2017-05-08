/* 
================================================================================
檔案代號:ooab_t
檔案名稱:營運據點層級參數表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:P
多語系檔案:N
============.========================.==========================================
 */
create table ooab_t
(
ooabent       number(5)      ,/* 企業編號 */
ooabsite       varchar2(10)      ,/* 營運據點 */
ooab001       varchar2(10)      ,/* 參數編號 */
ooab002       varchar2(80)      ,/* 參數資料 */
ooabownid       varchar2(20)      ,/* 資料所有者 */
ooabowndp       varchar2(10)      ,/* 資料所屬部門 */
ooabcrtid       varchar2(20)      ,/* 資料建立者 */
ooabcrtdp       varchar2(10)      ,/* 資料建立部門 */
ooabcrtdt       timestamp(0)      ,/* 資料創建日 */
ooabmodid       varchar2(20)      ,/* 資料修改者 */
ooabmoddt       timestamp(0)      ,/* 最近修改日 */
ooabstus       varchar2(10)      /* 狀態碼 */
);
alter table ooab_t add constraint ooab_pk primary key (ooabent,ooabsite,ooab001) enable validate;

create unique index ooab_pk on ooab_t (ooabent,ooabsite,ooab001);

grant select on ooab_t to tiptop;
grant update on ooab_t to tiptop;
grant delete on ooab_t to tiptop;
grant insert on ooab_t to tiptop;

exit;
