/* 
================================================================================
檔案代號:stfw_t
檔案名稱:專櫃合同遞增設定主檔明細表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table stfw_t
(
stfwent       number(5)      ,/* 企業編號 */
stfwunit       varchar2(10)      ,/* 應用組織 */
stfwsite       varchar2(10)      ,/* 營運據點 */
stfwseq       number(10,0)      ,/* 項次 */
stfw001       varchar2(20)      ,/* 合同編號 */
stfw002       varchar2(10)      ,/* 遞增類型 */
stfw003       number(10,0)      ,/* 遞增項次 */
stfw004       varchar2(10)      ,/* 遞增編號 */
stfw005       date      ,/* 起始日期 */
stfw006       date      ,/* 截止日期 */
stfw007       varchar2(10)      ,/* 遞增方式 */
stfw008       number(20,6)      ,/* 遞增幅度 */
stfwacti       varchar2(1)      /* 有效 */
);
alter table stfw_t add constraint stfw_pk primary key (stfwent,stfwseq,stfw001) enable validate;

create unique index stfw_pk on stfw_t (stfwent,stfwseq,stfw001);

grant select on stfw_t to tiptop;
grant update on stfw_t to tiptop;
grant delete on stfw_t to tiptop;
grant insert on stfw_t to tiptop;

exit;
