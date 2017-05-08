/* 
================================================================================
檔案代號:lokg_t
檔案名稱:訊息通知記錄檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table lokg_t
(
lokgent       number(5)      ,/* 企業代碼 */
lokgownid       varchar2(20)      ,/* 資料所有者 */
lokgowndp       varchar2(10)      ,/* 資料所屬部門 */
lokgcrtid       varchar2(20)      ,/* 資料建立者 */
lokgcrtdp       varchar2(10)      ,/* 資料建立部門 */
lokgcrtdt       timestamp(0)      ,/* 資料創建日 */
lokgmodid       varchar2(20)      ,/* 資料修改者 */
lokgmoddt       timestamp(0)      ,/* 最近修改日 */
lokgcnfid       varchar2(20)      ,/* 資料確認者 */
lokgcnfdt       timestamp(0)      ,/* 資料確認日 */
lokgstus       varchar2(10)      ,/* 狀態碼 */
lokg001       varchar2(80)      ,/* 訊息ID */
lokg002       varchar2(20)      ,/* 使用者編號 */
lokg003       varchar2(20)      ,/* 員工編號 */
lokg004       varchar2(40)      ,/* 模板ID */
lokg005       varchar2(80)      ,/* 模板名稱 */
lokg006       varchar2(255)      ,/* 實體檔案網址 */
lokg007       varchar2(255)      ,/* Web報表網址 */
lokg008       varchar2(255)      ,/* Mobile APP網址 */
lokg009       varchar2(80)      ,/* 訊息批號 */
lokg010       varchar2(80)      ,/* 訊息包序號 */
lokg011       clob      ,/* Param XML */
lokg012       varchar2(10)      ,/* 來源應用程式 */
lokg013       varchar2(1)      ,/* 重要性 */
lokg014       varchar2(1)      ,/* 通知分類 */
lokg015       timestamp(0)      ,/* 訊息日期 */
lokg016       varchar2(20)      ,/* 發送者 */
lokg017       timestamp(0)      ,/* 回報時間 */
lokg018       varchar2(4000)      ,/* 回報資訊 */
lokg019       varchar2(255)      ,/* 訊息title */
lokg020       varchar2(4000)      ,/* 訊息內容 */
lokg021       varchar2(1)      ,/* 結案否 */
lokg022       varchar2(10)      ,/* 群組類別代號 */
lokg023       varchar2(80)      ,/* 群組類別名稱 */
lokg024       varchar2(1)      ,/* 設定類別 */
lokg025       varchar2(20)      ,/* 建議執行作業 */
lokg026       varchar2(80)      ,/* 個人行動化建議執行功能 */
lokg027       varchar2(1)      /* 工廠行動化建議執行功能 */
);
alter table lokg_t add constraint lokg_pk primary key (lokgent,lokg001) enable validate;

create unique index lokg_pk on lokg_t (lokgent,lokg001);

grant select on lokg_t to tiptop;
grant update on lokg_t to tiptop;
grant delete on lokg_t to tiptop;
grant insert on lokg_t to tiptop;

exit;
