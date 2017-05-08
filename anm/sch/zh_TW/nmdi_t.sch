/* 
================================================================================
檔案代號:nmdi_t
檔案名稱:網銀操作記錄檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table nmdi_t
(
nmdi001       varchar2(1)      ,/* 鎖定標示 */
nmdi002       varchar2(20)      ,/* 操作流水號 */
nmdi003       varchar2(20)      ,/* 操作人員 */
nmdi004       timestamp(0)      ,/* 操作日期時間 */
nmdi005       varchar2(1)      ,/* 操作類型 */
nmdi006       varchar2(40)      ,/* 帳戶編碼 */
nmdi007       varchar2(40)      ,/* 交易帳戶編碼 */
nmdi008       varchar2(40)      ,/* 交易類型編號 */
nmdi009       varchar2(10)      ,/* 交易版本 */
nmdi010       varchar2(20)      ,/* 資料包編號 */
nmdi011       varchar2(20)      ,/* 資料包項次 */
nmdi012       date      ,/* 查詢開始日期 */
nmdi013       date      ,/* 查詢截止日期 */
nmdi014       varchar2(255)      ,/* 報文異常說明 */
nmdi015       varchar2(20)      ,/* 支付申請單號 */
nmdi016       varchar2(10)      ,/* 支付結果代碼 */
nmdi017       varchar2(255)      ,/* 支付異常說明 */
nmdi018       varchar2(255)      ,/* 其他資訊 */
nmdient       number(5)      /* 企業編碼 */
);
alter table nmdi_t add constraint nmdi_pk primary key (nmdi002,nmdi006,nmdi007,nmdi010,nmdi011,nmdient) enable validate;

create unique index nmdi_pk on nmdi_t (nmdi002,nmdi006,nmdi007,nmdi010,nmdi011,nmdient);

grant select on nmdi_t to tiptop;
grant update on nmdi_t to tiptop;
grant delete on nmdi_t to tiptop;
grant insert on nmdi_t to tiptop;

exit;
