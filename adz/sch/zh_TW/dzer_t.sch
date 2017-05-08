/* 
================================================================================
檔案代號:dzer_t
檔案名稱:多語言關聯設定檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table dzer_t
(
dzerstus       varchar2(10)      ,/* 狀態碼 */
dzer001       varchar2(15)      ,/* Table代號 */
dzer002       varchar2(80)      ,/* 依附欄位 */
dzer003       number(10,0)      ,/* 依附序號 */
dzer004       varchar2(80)      ,/* 來源參考欄位 */
dzer005       varchar2(15)      ,/* 取值表格 */
dzer006       varchar2(80)      ,/* 取值參考欄位 */
dzer007       varchar2(80)      ,/* 取值欄位 */
dzer008       varchar2(80)      ,/* 多語言欄位 */
dzerownid       varchar2(20)      ,/* 資料所有者 */
dzerowndp       varchar2(10)      ,/* 資料所屬部門 */
dzercrtid       varchar2(20)      ,/* 資料建立者 */
dzercrtdp       varchar2(10)      ,/* 資料建立部門 */
dzercrtdt       timestamp(0)      ,/* 資料創建日 */
dzermodid       varchar2(20)      ,/* 資料修改者 */
dzermoddt       timestamp(0)      ,/* 最近修改日 */
dzercnfid       varchar2(20)      ,/* 資料確認者 */
dzercnfdt       timestamp(0)      /* 資料確認日 */
);
alter table dzer_t add constraint dzer_pk primary key (dzer001,dzer002) enable validate;

create unique index dzer_pk on dzer_t (dzer001,dzer002);

grant select on dzer_t to tiptop;
grant update on dzer_t to tiptop;
grant delete on dzer_t to tiptop;
grant insert on dzer_t to tiptop;

exit;
