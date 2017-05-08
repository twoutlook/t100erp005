/* 
================================================================================
檔案代號:gzwl_t
檔案名稱:執行程式授權紀錄表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table gzwl_t
(
gzwl001       varchar2(20)      ,/* Session Key */
gzwl002       varchar2(20)      ,/* 使用者編號 */
gzwl003       varchar2(20)      ,/* 作業編號 */
gzwl004       timestamp(0)      ,/* 執行開始時間 */
gzwl005       varchar2(100)      ,/* 授權編號 */
gzwl006       varchar2(40)      ,/* 使用者IP */
gzwl007       varchar2(10)      ,/* 執行模式 */
gzwl008       varchar2(20)      ,/* PID */
gzwl009       varchar2(20)      ,/* 員工編號 */
gzwl010       varchar2(20)      ,/* 執行區域(備用) */
gzwl011       varchar2(10)      ,/* 歸屬部門 */
gzwl012       number(5)      ,/* 企業代碼 */
gzwl013       varchar2(40)      ,/* WS產品來源 */
gzwl014       varchar2(1)      ,/* 背景作業 */
gzwl015       varchar2(20)      /* AP主機 */
);
alter table gzwl_t add constraint gzwl_pk primary key (gzwl001) enable validate;

create unique index gzwl_pk on gzwl_t (gzwl001);

grant select on gzwl_t to tiptop;
grant update on gzwl_t to tiptop;
grant delete on gzwl_t to tiptop;
grant insert on gzwl_t to tiptop;

exit;
