/* 
================================================================================
檔案代號:stfe_t
檔案名稱:專櫃合同保底費用設定檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table stfe_t
(
stfeent       number(5)      ,/* 企業編號 */
stfesite       varchar2(10)      ,/* 營運據點 */
stfeunit       varchar2(10)      ,/* 應用組織 */
stfe001       varchar2(20)      ,/* 合同編號 */
stfeseq       number(10,0)      ,/* 項次 */
stfe002       varchar2(10)      ,/* 方案編號 */
stfe003       varchar2(10)      ,/* 費用編號 */
stfe004       varchar2(10)      ,/* 保底方式 */
stfe005       varchar2(10)      ,/* 分量扣點方式 */
stfe006       varchar2(10)      ,/* 保底計算週期 */
stfe007       number(20,6)      ,/* 月預扣標準 */
stfe008       date      ,/* 開始日期 */
stfe009       date      ,/* 截止日期 */
stfe010       date      ,/* 下次計算日 */
stfe011       varchar2(255)      ,/* 備註 */
stfe012       varchar2(10)      /* 月預扣方式 */
);
alter table stfe_t add constraint stfe_pk primary key (stfeent,stfe001,stfeseq,stfe002) enable validate;

create unique index stfe_pk on stfe_t (stfeent,stfe001,stfeseq,stfe002);

grant select on stfe_t to tiptop;
grant update on stfe_t to tiptop;
grant delete on stfe_t to tiptop;
grant insert on stfe_t to tiptop;

exit;
