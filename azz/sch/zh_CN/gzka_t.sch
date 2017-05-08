/* 
================================================================================
檔案代號:gzka_t
檔案名稱:訊息中心設定
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table gzka_t
(
gzka001       varchar2(20)      ,/* 程式代號 */
gzka002       varchar2(80)      ,/* 功能選項 */
gzka003       varchar2(1)      ,/* 通知條件 */
gzka004       varchar2(1)      ,/* 通知類型 */
gzka005       varchar2(1)      ,/* 重要性 */
gzka006       varchar2(20)      ,/* 建議執行作業 */
gzka007       varchar2(80)      ,/* 個人行動化建議執行功能 */
gzkastus       varchar2(1)      ,/* 有效否 */
gzkaownid       varchar2(20)      ,/* 資料所有者 */
gzkaowndp       varchar2(10)      ,/* 資料所屬部門 */
gzkacrtid       varchar2(20)      ,/* 資料建立者 */
gzkacrtdp       varchar2(10)      ,/* 資料建立部門 */
gzkacrtdt       timestamp(0)      ,/* 資料創建日 */
gzkamodid       varchar2(20)      ,/* 資料修改者 */
gzkamoddt       timestamp(0)      ,/* 最近修改日 */
gzka008       varchar2(10)      ,/* 條件內容 */
gzka009       varchar2(1)      ,/* 訊息提示 */
gzka010       varchar2(1)      ,/* 群組類別 */
gzka011       varchar2(1)      ,/* 資料呈現格式 */
gzka012       varchar2(1)      ,/* 設定類別 */
gzkaent       number(5)      ,/* 企業代碼 */
gzka013       varchar2(1)      /* 工廠行動化建議執行功能 */
);
alter table gzka_t add constraint gzka_pk primary key (gzka001,gzka002,gzka003,gzka008,gzka012,gzkaent) enable validate;

create unique index gzka_pk on gzka_t (gzka001,gzka002,gzka003,gzka008,gzka012,gzkaent);

grant select on gzka_t to tiptop;
grant update on gzka_t to tiptop;
grant delete on gzka_t to tiptop;
grant insert on gzka_t to tiptop;

exit;
