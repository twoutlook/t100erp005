/* 
================================================================================
檔案代號:dzes_t
檔案名稱:表格及欄位修改紀錄檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table dzes_t
(
dzesstus       varchar2(10)      ,/* 狀態碼 */
dzes001       varchar2(60)      ,/* 版本號 */
dzes002       varchar2(10)      ,/* 主執行別 */
dzes003       varchar2(60)      ,/* 主物件類別 */
dzes004       varchar2(60)      ,/* 主物件名稱 */
dzes005       varchar2(10)      ,/* 次執行別 */
dzes006       varchar2(60)      ,/* 次物件類別 */
dzes007       varchar2(60)      ,/* 次物件名稱 */
dzes008       varchar2(40)      ,/* 型態 */
dzes009       varchar2(60)      ,/* 長度或其他物件名稱 */
dzes010       varchar2(10)      ,/* 可否為空值 */
dzes011       varchar2(80)      ,/* 名稱/註解 */
dzes012       varchar2(60)      ,/* 需求或專案代號 */
dzes013       number(22,2)      ,/* 序號 */
dzes014       varchar2(1)      ,/* 處理碼 */
dzesownid       varchar2(20)      ,/* 資料所有者 */
dzesowndp       varchar2(10)      ,/* 資料所屬部門 */
dzescrtid       varchar2(20)      ,/* 資料建立者 */
dzescrtdp       varchar2(10)      ,/* 資料建立部門 */
dzescrtdt       timestamp(0)      ,/* 資料創建日 */
dzesmodid       varchar2(20)      ,/* 資料修改者 */
dzesmoddt       timestamp(0)      ,/* 最近修改日 */
dzescnfid       varchar2(20)      ,/* 資料確認者 */
dzescnfdt       timestamp(0)      /* 資料確認日 */
);

create  index dzes_i1 on dzes_t (dzes001);
create  index dzes_i2 on dzes_t (dzes012);

grant select on dzes_t to tiptop;
grant update on dzes_t to tiptop;
grant delete on dzes_t to tiptop;
grant insert on dzes_t to tiptop;

exit;
