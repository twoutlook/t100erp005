/* 
================================================================================
檔案代號:xcbr_t
檔案名稱:工藝成本工時單身檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table xcbr_t
(
xcbrent       number(5)      ,/* 企業編號 */
xcbrsite       varchar2(10)      ,/* 營運據點 */
xcbrcomp       varchar2(10)      ,/* 法人組織 */
xcbrdocno       varchar2(20)      ,/* 單據編號 */
xcbrseq       number(10,0)      ,/* 行序 */
xcbr001       varchar2(10)      ,/* 成本中心 */
xcbr002       varchar2(20)      ,/* 工單編號 */
xcbr003       varchar2(10)      ,/* 作業編號 */
xcbr004       varchar2(10)      ,/* 製程式 */
xcbr009       varchar2(80)      ,/* 備註 */
xcbr099       number(20,6)      ,/* 良品數量 */
xcbr100       number(20,6)      ,/* 報廢數量 */
xcbr101       number(20,6)      ,/* 期末在制數量 */
xcbr102       number(20,6)      ,/* 期末在制約當率 */
xcbr103       number(20,6)      ,/* 期末在制約當量 */
xcbr104       number(20,6)      ,/* 報工數量 */
xcbr201       number(15,3)      ,/* 實際工時 */
xcbr202       number(15,3)      ,/* 實際機時 */
xcbr203       number(15,3)      ,/* 標準工時 */
xcbr204       number(15,3)      /* 標準機時 */
);
alter table xcbr_t add constraint xcbr_pk primary key (xcbrent,xcbrdocno,xcbrseq) enable validate;

create unique index xcbr_pk on xcbr_t (xcbrent,xcbrdocno,xcbrseq);

grant select on xcbr_t to tiptop;
grant update on xcbr_t to tiptop;
grant delete on xcbr_t to tiptop;
grant insert on xcbr_t to tiptop;

exit;
