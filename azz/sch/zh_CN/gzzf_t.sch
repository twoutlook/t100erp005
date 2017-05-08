/* 
================================================================================
檔案代號:gzzf_t
檔案名稱:作業級畫面元件翻譯代換表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table gzzf_t
(
gzzfownid       varchar2(20)      ,/* 資料所有者 */
gzzfowndp       varchar2(10)      ,/* 資料所屬部門 */
gzzfcrtid       varchar2(20)      ,/* 資料建立者 */
gzzfcrtdp       varchar2(10)      ,/* 資料建立部門 */
gzzfcrtdt       timestamp(0)      ,/* 資料創建日 */
gzzfmodid       varchar2(20)      ,/* 資料修改者 */
gzzfmoddt       timestamp(0)      ,/* 最近修改日 */
gzzfstus       varchar2(10)      ,/* 狀態碼 */
gzzf001       varchar2(20)      ,/* 作業編號 */
gzzf002       varchar2(6)      ,/* 語言別 */
gzzf003       varchar2(80)      ,/* 待轉標籤 */
gzzf004       varchar2(1)      ,/* 使用標示 */
gzzf005       varchar2(255)      ,/* 轉換標籤文字 */
gzzf006       varchar2(255)      /* 轉換註解 */
);
alter table gzzf_t add constraint gzzf_pk primary key (gzzf001,gzzf002,gzzf003) enable validate;

create unique index gzzf_pk on gzzf_t (gzzf001,gzzf002,gzzf003);

grant select on gzzf_t to tiptop;
grant update on gzzf_t to tiptop;
grant delete on gzzf_t to tiptop;
grant insert on gzzf_t to tiptop;

exit;
