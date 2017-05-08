/* 
================================================================================
檔案代號:pjby_t
檔案名稱:專案報工資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table pjby_t
(
pjbyent       number(5)      ,/* 企業編號 */
pjbysite       varchar2(10)      ,/* 營運據點 */
pjbycomp       varchar2(10)      ,/* 法人組織 */
pjbyseq       number(10,0)      ,/* 行序 */
pjby001       date      ,/* 日期 */
pjby002       varchar2(10)      ,/* 專案人員 */
pjby003       varchar2(10)      ,/* 專案部門 */
pjby004       varchar2(20)      ,/* 專案編號 */
pjby005       varchar2(10)      ,/* WBS編號 */
pjby006       varchar2(30)      ,/* 活動編號 */
pjby009       varchar2(80)      ,/* 備註 */
pjby201       number(15,3)      ,/* 專案工時 */
pjbyownid       varchar2(20)      ,/* 資料所有者 */
pjbyowndp       varchar2(10)      ,/* 資料所屬部門 */
pjbycrtid       varchar2(20)      ,/* 資料建立者 */
pjbycrtdp       varchar2(10)      ,/* 資料建立部門 */
pjbycrtdt       timestamp(0)      ,/* 資料創建日 */
pjbymodid       varchar2(20)      ,/* 資料修改者 */
pjbymoddt       timestamp(0)      ,/* 最近修改日 */
pjbystus       varchar2(10)      /* 狀態碼 */
);
alter table pjby_t add constraint pjby_pk primary key (pjbyent,pjbyseq,pjby001,pjby002) enable validate;

create unique index pjby_pk on pjby_t (pjbyent,pjbyseq,pjby001,pjby002);

grant select on pjby_t to tiptop;
grant update on pjby_t to tiptop;
grant delete on pjby_t to tiptop;
grant insert on pjby_t to tiptop;

exit;
