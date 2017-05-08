/* 
================================================================================
檔案代號:stff_t
檔案名稱:專櫃合同保底費用明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table stff_t
(
stffent       number(5)      ,/* 企業編號 */
stffsite       varchar2(10)      ,/* 營運據點 */
stffunit       varchar2(10)      ,/* 應用組織 */
stff001       varchar2(20)      ,/* 合同編號 */
stffseq       number(10,0)      ,/* 項次 */
stff002       varchar2(10)      ,/* 方案編號 */
stff003       number(10,0)      ,/* 保底項次 */
stff004       number(10,0)      ,/* 段號 */
stff005       varchar2(10)      ,/* 庫區編號 */
stff006       number(20,6)      ,/* 截止金額 */
stff007       number(20,6)      ,/* 起始金額 */
stff008       number(20,6)      ,/* 執行扣率 */
stff009       varchar2(255)      ,/* 備註 */
stff010       varchar2(1)      ,/* 執行方式 */
stff011       number(20,6)      /* 執行金額 */
);
alter table stff_t add constraint stff_pk primary key (stffent,stff001,stffseq,stff002,stff003) enable validate;

create unique index stff_pk on stff_t (stffent,stff001,stffseq,stff002,stff003);

grant select on stff_t to tiptop;
grant update on stff_t to tiptop;
grant delete on stff_t to tiptop;
grant insert on stff_t to tiptop;

exit;
