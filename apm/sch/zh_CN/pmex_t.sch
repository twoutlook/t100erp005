/* 
================================================================================
檔案代號:pmex_t
檔案名稱:採購折扣合約單明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table pmex_t
(
pmexent       number(5)      ,/* 企業編號 */
pmexsite       varchar2(10)      ,/* 營運據點 */
pmexdocno       varchar2(20)      ,/* 合約單號 */
pmexseq       number(10,0)      ,/* 項次 */
pmex001       varchar2(10)      ,/* 類型 */
pmex002       varchar2(40)      ,/* 資料編號 */
pmex003       varchar2(256)      ,/* 產品特徵 */
pmex005       varchar2(1)      ,/* 折扣方式 */
pmex006       varchar2(10)      ,/* 計價單位 */
pmex007       number(20,6)      ,/* 單價 */
pmex008       number(20,6)      ,/* 折扣率 */
pmex009       varchar2(1)      ,/* 分段折扣否 */
pmex010       date      ,/* 最近結算日期 */
pmex011       date      ,/* 結算起始日期 */
pmex012       date      ,/* 結算截止日期 */
pmex020       varchar2(255)      /* 備註 */
);
alter table pmex_t add constraint pmex_pk primary key (pmexent,pmexdocno,pmexseq) enable validate;

create unique index pmex_pk on pmex_t (pmexent,pmexdocno,pmexseq);

grant select on pmex_t to tiptop;
grant update on pmex_t to tiptop;
grant delete on pmex_t to tiptop;
grant insert on pmex_t to tiptop;

exit;
