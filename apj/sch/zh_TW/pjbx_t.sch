/* 
================================================================================
檔案代號:pjbx_t
檔案名稱:專案成本要素分攤設置檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table pjbx_t
(
pjbxent       number(5)      ,/* 企業編號 */
pjbxld       varchar2(5)      ,/* 帳別編號 */
pjbx001       varchar2(1)      ,/* 分攤類型 */
pjbx002       number(5,0)      ,/* 年度 */
pjbx003       number(5,0)      ,/* 期別 */
pjbx004       varchar2(20)      ,/* 專案編號 */
pjbx005       varchar2(24)      ,/* 科目編號 */
pjbx006       varchar2(10)      ,/* 部門編號 */
pjbx008       varchar2(1)      ,/* 部門屬性 */
pjbx009       number(15,3)      ,/* 分攤權數 */
pjbxownid       varchar2(20)      ,/* 資料所有者 */
pjbxowndp       varchar2(10)      ,/* 資料所屬部門 */
pjbxcrtid       varchar2(20)      ,/* 資料建立者 */
pjbxcrtdp       varchar2(10)      ,/* 資料建立部門 */
pjbxcrtdt       timestamp(0)      ,/* 資料創建日 */
pjbxmodid       varchar2(20)      ,/* 資料修改者 */
pjbxmoddt       timestamp(0)      ,/* 最近修改日 */
pjbxstus       varchar2(10)      /* 狀態碼 */
);
alter table pjbx_t add constraint pjbx_pk primary key (pjbxent,pjbxld,pjbx001,pjbx002,pjbx003,pjbx004,pjbx005,pjbx006) enable validate;

create unique index pjbx_pk on pjbx_t (pjbxent,pjbxld,pjbx001,pjbx002,pjbx003,pjbx004,pjbx005,pjbx006);

grant select on pjbx_t to tiptop;
grant update on pjbx_t to tiptop;
grant delete on pjbx_t to tiptop;
grant insert on pjbx_t to tiptop;

exit;
