/* 
================================================================================
檔案代號:qcbn_t
檔案名稱:倉庫檢驗申請單主檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table qcbn_t
(
qcbnent       number(5)      ,/* 企業編號 */
qcbnsite       varchar2(10)      ,/* 營運據點 */
qcbndocno       varchar2(20)      ,/* 申請單號 */
qcbndocdt       date      ,/* 單據日期 */
qcbn001       varchar2(20)      ,/* 申請人員 */
qcbn002       varchar2(10)      ,/* 申請部門 */
qcbn003       varchar2(40)      ,/* 料件編號 */
qcbn004       varchar2(256)      ,/* 產品特徵 */
qcbn005       varchar2(10)      ,/* 庫位 */
qcbn006       varchar2(10)      ,/* 儲位 */
qcbn007       varchar2(30)      ,/* 批號 */
qcbn008       varchar2(30)      ,/* 庫存管理特徵 */
qcbn009       varchar2(10)      ,/* 交易對象編號 */
qcbn010       varchar2(10)      ,/* 庫存單位 */
qcbn011       number(20,6)      ,/* 待驗量 */
qcbn012       varchar2(10)      ,/* 緊急度 */
qcbn013       varchar2(255)      ,/* 備註 */
qcbnownid       varchar2(20)      ,/* 資料所屬者 */
qcbnowndp       varchar2(10)      ,/* 資料所屬部門 */
qcbncrtid       varchar2(20)      ,/*   */
qcbncrtdp       varchar2(10)      ,/*   */
qcbncrtdt       timestamp(0)      ,/* 資料創建日 */
qcbnmodid       varchar2(20)      ,/*   */
qcbnmoddt       timestamp(0)      ,/*   */
qcbncnfid       varchar2(20)      ,/*   */
qcbncnfdt       timestamp(0)      ,/*   */
qcbnpstid       varchar2(20)      ,/* 資料過帳者 */
qcbnpstdt       timestamp(0)      ,/* 資料過帳日 */
qcbnstus       varchar2(10)      /* 狀態碼 */
);
alter table qcbn_t add constraint qcbn_pk primary key (qcbnent,qcbndocno) enable validate;

create unique index qcbn_pk on qcbn_t (qcbnent,qcbndocno);

grant select on qcbn_t to tiptop;
grant update on qcbn_t to tiptop;
grant delete on qcbn_t to tiptop;
grant insert on qcbn_t to tiptop;

exit;
