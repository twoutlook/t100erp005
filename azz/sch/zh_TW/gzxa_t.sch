/* 
================================================================================
檔案代號:gzxa_t
檔案名稱:使用者資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table gzxa_t
(
gzxastus       varchar2(10)      ,/* 狀態碼 */
gzxaent       number(5)      ,/* 企業編號 */
gzxa001       varchar2(20)      ,/* 使用者編號 */
gzxa002       varchar2(10)      ,/* 聯絡對象識別碼 */
gzxa003       varchar2(20)      ,/* 員工編號 */
gzxa004       varchar2(80)      ,/* 使用者E-mail */
gzxa005       varchar2(80)      ,/* 使用者AD帳號 */
gzxa006       varchar2(80)      ,/* 使用者QQ帳號 */
gzxa007       varchar2(10)      ,/* 預設營運據點編號 */
gzxa008       varchar2(40)      ,/* 首頁風格 */
gzxa009       varchar2(10)      ,/* 地圖引擎 */
gzxa010       varchar2(6)      ,/* 使用語言 */
gzxa011       varchar2(20)      ,/* 自定目錄編號 */
gzxa012       varchar2(1)      ,/* 依照權限調整使用者目錄 */
gzxa013       varchar2(40)      ,/* 使用者流程編號 */
gzxa014       date      ,/* 使用者可用截止日期 */
gzxaownid       varchar2(20)      ,/* 資料所有者 */
gzxaowndp       varchar2(10)      ,/* 資料所屬部門 */
gzxacrtid       varchar2(20)      ,/* 資料建立者 */
gzxacrtdp       varchar2(10)      ,/* 資料建立部門 */
gzxacrtdt       timestamp(0)      ,/* 資料創建日 */
gzxamodid       varchar2(20)      ,/* 資料修改者 */
gzxamoddt       timestamp(0)      ,/* 最近修改日 */
gzxa015       varchar2(10)      ,/* 作業執行模式 */
gzxa016       varchar2(1)      ,/* 首頁選單是否固定 */
gzxa017       varchar2(20)      /* 手機/電話 */
);
alter table gzxa_t add constraint gzxa_pk primary key (gzxaent,gzxa001) enable validate;

create unique index gzxa_pk on gzxa_t (gzxaent,gzxa001);

grant select on gzxa_t to tiptop;
grant update on gzxa_t to tiptop;
grant delete on gzxa_t to tiptop;
grant insert on gzxa_t to tiptop;

exit;
