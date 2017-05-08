/* 
================================================================================
檔案代號:stee_t
檔案名稱:專櫃合同保底費用申请檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table stee_t
(
steeent       number(5)      ,/* 企業編號 */
steesite       varchar2(10)      ,/* 營運據點 */
steeunit       varchar2(10)      ,/* 應用組織 */
steedocno       varchar2(20)      ,/* 單據編號 */
steeseq       number(10,0)      ,/* 項次 */
stee001       varchar2(20)      ,/* 合同編號 */
stee002       varchar2(10)      ,/* 方案編號 */
stee003       varchar2(10)      ,/* 費用編號 */
stee004       varchar2(10)      ,/* 保底方式 */
stee005       varchar2(10)      ,/* 分量扣點方式 */
stee006       varchar2(10)      ,/* 保底計算週期 */
stee007       number(20,6)      ,/* 月預扣標準 */
stee008       date      ,/* 開始日期 */
stee009       date      ,/* 截止日期 */
stee010       date      ,/* 下次計算日 */
stee011       varchar2(255)      ,/* 備註 */
stee012       varchar2(10)      /* 月預扣方式 */
);
alter table stee_t add constraint stee_pk primary key (steeent,steedocno,steeseq,stee002) enable validate;

create unique index stee_pk on stee_t (steeent,steedocno,steeseq,stee002);

grant select on stee_t to tiptop;
grant update on stee_t to tiptop;
grant delete on stee_t to tiptop;
grant insert on stee_t to tiptop;

exit;
