/* 
================================================================================
檔案代號:gzze_t
檔案名稱:錯誤訊息表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:Y
============.========================.==========================================
 */
create table gzze_t
(
gzzestus       varchar2(10)      ,/* 狀態碼 */
gzze001       varchar2(10)      ,/* 錯誤訊息編號 */
gzze002       varchar2(6)      ,/* 語言別 */
gzze003       varchar2(255)      ,/* 錯誤訊息 */
gzze004       varchar2(500)      ,/* 建議處理方式 */
gzzeownid       varchar2(20)      ,/* 資料所有者 */
gzzeowndp       varchar2(10)      ,/* 資料所屬部門 */
gzzecrtid       varchar2(20)      ,/* 資料建立者 */
gzzecrtdp       varchar2(10)      ,/* 資料建立部門 */
gzzecrtdt       timestamp(0)      ,/* 資料創建日 */
gzzemodid       varchar2(20)      ,/* 資料修改者 */
gzzemoddt       timestamp(0)      ,/* 最近修改日 */
gzze005       varchar2(20)      ,/* 建議執行作業 */
gzze006       varchar2(500)      ,/* 程式人員詳細訊息 */
gzze007       varchar2(1)      ,/* 訊息類別 */
gzze008       varchar2(1)      ,/* 強制開窗 */
gzze009       varchar2(80)      /* 歸屬行業別 */
);
alter table gzze_t add constraint gzze_pk primary key (gzze001,gzze002) enable validate;

create unique index gzze_pk on gzze_t (gzze001,gzze002);

grant select on gzze_t to tiptop;
grant update on gzze_t to tiptop;
grant delete on gzze_t to tiptop;
grant insert on gzze_t to tiptop;

exit;
