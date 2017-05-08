/* 
================================================================================
檔案代號:stfr_t
檔案名稱:聯營合同單價收費項目模板設定檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table stfr_t
(
stfrent       number(5)      ,/* 企業編號 */
stfrunit       varchar2(10)      ,/* 應用組織 */
stfrsite       varchar2(10)      ,/* 營運組織 */
stfrseq       number(10,0)      ,/* 項次 */
stfr001       varchar2(20)      ,/* 模板編號 */
stfr002       varchar2(10)      ,/* 費用編號 */
stfr003       varchar2(10)      ,/* 費用類型 */
stfr004       varchar2(10)      ,/* 價款類型 */
stfr005       varchar2(1)      ,/* 納入結算單否 */
stfr006       varchar2(1)      ,/* 票扣否 */
stfr007       number(20,6)      ,/* 單價 */
stfr008       number(10,0)      ,/* 優惠度數 */
stfr009       number(20,6)      ,/* 優惠度額 */
stfracti       varchar2(1)      ,/* 資料有效碼 */
stfr010       varchar2(20)      ,/* 費用單號 */
stfr011       number(10,0)      /* 費用單項次 */
);
alter table stfr_t add constraint stfr_pk primary key (stfrent,stfrseq,stfr001) enable validate;

create unique index stfr_pk on stfr_t (stfrent,stfrseq,stfr001);

grant select on stfr_t to tiptop;
grant update on stfr_t to tiptop;
grant delete on stfr_t to tiptop;
grant insert on stfr_t to tiptop;

exit;
