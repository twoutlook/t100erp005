/* 
================================================================================
檔案代號:stew_t
檔案名稱:專櫃合同遞增設定申請明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table stew_t
(
stewent       number(5)      ,/* 企業編號 */
stewunit       varchar2(10)      ,/* 應用組織 */
stewdocno       varchar2(20)      ,/* 單據編號 */
stewsite       varchar2(10)      ,/* 營運據點 */
stewseq       number(10,0)      ,/* 項次 */
stew001       varchar2(20)      ,/* 合同編號 */
stew002       varchar2(10)      ,/* 遞增類型 */
stew003       number(10,0)      ,/* 遞增項次 */
stew004       varchar2(10)      ,/* 遞增編號 */
stew005       date      ,/* 起始日期 */
stew006       date      ,/* 截止日期 */
stew007       varchar2(10)      ,/* 遞增方式 */
stew008       number(20,6)      ,/* 遞增幅度 */
stewacti       varchar2(1)      /* 有效 */
);
alter table stew_t add constraint stew_pk primary key (stewent,stewdocno,stewseq) enable validate;

create unique index stew_pk on stew_t (stewent,stewdocno,stewseq);

grant select on stew_t to tiptop;
grant update on stew_t to tiptop;
grant delete on stew_t to tiptop;
grant insert on stew_t to tiptop;

exit;
