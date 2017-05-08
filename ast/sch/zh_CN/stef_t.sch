/* 
================================================================================
檔案代號:stef_t
檔案名稱:專櫃合同保底費用申请明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table stef_t
(
stefent       number(5)      ,/* 企業編號 */
stefsite       varchar2(10)      ,/* 營運據點 */
stefunit       varchar2(10)      ,/* 應用組織 */
stefdocno       varchar2(20)      ,/* 單據編號 */
stefseq       number(10,0)      ,/* 項次 */
stef001       varchar2(20)      ,/* 合同編號 */
stef002       varchar2(10)      ,/* 方案編號 */
stef003       number(10,0)      ,/* 保底項次 */
stef004       number(10,0)      ,/* 段號 */
stef005       varchar2(10)      ,/* 庫區編號 */
stef006       number(20,6)      ,/* 起始金額 */
stef007       number(20,6)      ,/* 截止金額 */
stef008       number(20,6)      ,/* 執行扣率 */
stef009       varchar2(255)      ,/* 備註 */
stef010       varchar2(1)      ,/* 執行方式 */
stef011       number(20,6)      /* 執行金額 */
);
alter table stef_t add constraint stef_pk primary key (stefent,stefdocno,stefseq,stef002,stef003) enable validate;

create unique index stef_pk on stef_t (stefent,stefdocno,stefseq,stef002,stef003);

grant select on stef_t to tiptop;
grant update on stef_t to tiptop;
grant delete on stef_t to tiptop;
grant insert on stef_t to tiptop;

exit;
