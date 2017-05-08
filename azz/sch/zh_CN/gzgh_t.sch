/* 
================================================================================
檔案代號:gzgh_t
檔案名稱:XtraGrid中繼檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table gzgh_t
(
gzgh001       varchar2(100)      ,/* 驗證碼 */
gzgh002       varchar2(255)      ,/* 報表樣板ID */
gzgh003       varchar2(100)      ,/* 主報表檔名 */
gzgh004       varchar2(255)      ,/* Title1 */
gzgh005       varchar2(255)      ,/* Title2 */
gzgh006       varchar2(80)      ,/* 製表者 */
gzgh007       timestamp(0)      ,/* 製表日期 */
gzgh008       varchar2(1000)      ,/* 列印條件 */
gzgh009       varchar2(255)      ,/* Logo URL */
gzgh010       varchar2(80)      ,/* 報表型態代號 */
gzgh011       varchar2(1000)      ,/* 模板名稱 */
gzgh012       varchar2(2000)      ,/* 自訂義SQL */
gzgh013       varchar2(255)      ,/* 自訂義連線資訊 */
gzgh014       varchar2(10)      ,/* 主題風格 */
gzgh015       varchar2(255)      ,/* 製表者所屬角色 */
gzgh016       varchar2(2000)      ,/* 隱藏欄位 */
gzgh017       varchar2(500)      ,/* 報表首資訊(1) */
gzgh018       varchar2(500)      ,/* 報表首資訊(2) */
gzgh019       varchar2(500)      ,/* 報表首資訊(3) */
gzgh020       varchar2(500)      ,/* 報表首資訊(4) */
gzgh021       varchar2(500)      ,/* 報表首資訊(5) */
gzgh022       varchar2(500)      ,/* 報表尾資訊(1) */
gzgh023       varchar2(500)      ,/* 報表尾資訊(2) */
gzgh024       varchar2(500)      ,/* 報表尾資訊(3) */
gzgh025       varchar2(500)      ,/* 報表尾資訊(4) */
gzgh026       varchar2(500)      ,/* 報表尾資訊(5) */
gzgh027       varchar2(1000)      ,/* 動態欄位標題 */
gzgh028       varchar2(100)      ,/* 子報表檔名 */
gzgh029       varchar2(500)      ,/* 簽核資料 */
gzgh030       varchar2(1000)      ,/* 收件者 */
gzgh031       varchar2(1000)      ,/* 副本 */
gzgh032       varchar2(1000)      ,/* 密件副本 */
gzgh033       varchar2(1000)      ,/* 郵件本文 */
gzgh034       varchar2(80)      ,/* 寄件者 */
gzgh035       varchar2(500)      ,/* 報表檔名 */
gzgh036       varchar2(80)      ,/* 直接送印設定 */
gzgh037       varchar2(1)      ,/* 自動產生檔案 */
gzgh038       varchar2(20)      ,/* 日期格式 */
gzgh039       varchar2(1)      ,/* 小數位符號 */
gzgh040       varchar2(1)      ,/* 千分位符號 */
gzgh041       clob      ,/* 欄位說明 */
gzgh042       varchar2(6)      ,/* 語言別 */
gzgh043       varchar2(1000)      ,/* 數值屬性的小數位數 */
gzgh044       number(5)      ,/* 企業編號 */
gzgh045       varchar2(20)      ,/* 資料庫編號 */
gzgh046       clob      ,/* 表頭資訊 */
gzgh047       varchar2(2000)      ,/* 不可視欄位代碼 */
gzgh048       varchar2(80)      ,/* 排程資訊 */
gzgh049       varchar2(40)      ,/* 歷史報表存放位置 */
gzgh050       varchar2(20)      ,/* 使用者允許印表方式 */
gzgh051       varchar2(255)      /* 郵件主旨 */
);
alter table gzgh_t add constraint gzgh_pk primary key (gzgh001) enable validate;

create unique index gzgh_pk on gzgh_t (gzgh001);

grant select on gzgh_t to tiptop;
grant update on gzgh_t to tiptop;
grant delete on gzgh_t to tiptop;
grant insert on gzgh_t to tiptop;

exit;
