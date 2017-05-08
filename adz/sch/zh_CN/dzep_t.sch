/* 
================================================================================
檔案代號:dzep_t
檔案名稱:欄位規格設計資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table dzep_t
(
dzepstus       varchar2(10)      ,/* 狀態碼 */
dzep001       varchar2(15)      ,/* table代號 */
dzep002       varchar2(20)      ,/* 欄位代號 */
dzep003       varchar2(1)      ,/* No Use */
dzep004       varchar2(1)      ,/* No Use */
dzep005       varchar2(1)      ,/* 必要欄位 */
dzep006       varchar2(1)      ,/* No Use */
dzep007       varchar2(1)      ,/* No Use */
dzep008       varchar2(1)      ,/* No Use */
dzep009       varchar2(10)      ,/* 顯示寬度 */
dzep010       varchar2(80)      ,/* 資料控制項 */
dzep011       varchar2(80)      ,/* 系統分類碼 */
dzep012       varchar2(100)      ,/* 預設值 */
dzep013       number(15,3)      ,/* 最大值 */
dzep014       number(15,3)      ,/* 最小值 */
dzep015       varchar2(1)      ,/* 是否可編輯 */
dzep016       varchar2(20)      ,/* 是否可查詢 */
dzep017       varchar2(20)      ,/* 編輯時開窗設定 */
dzep018       varchar2(20)      ,/* 查詢時開窗設定 */
dzep019       varchar2(500)      ,/* 校驗帶值設定 */
dzep020       varchar2(255)      ,/* 程式串查設定 */
dzep021       varchar2(40)      ,/* 顯示格式 */
dzep022       varchar2(1)      ,/* 串查型態 */
dzep023       varchar2(10)      ,/* 欄位大小寫 */
dzep024       varchar2(1)      ,/* No Use */
dzep025       varchar2(80)      ,/* 比較符號(最大值) */
dzep026       varchar2(80)      ,/* 比較符號(最小值) */
dzepownid       varchar2(20)      ,/* 資料所有者 */
dzepowndp       varchar2(10)      ,/* 資料所屬部門 */
dzepcrtid       varchar2(20)      ,/* 資料建立者 */
dzepcrtdp       varchar2(10)      ,/* 資料建立部門 */
dzepcrtdt       timestamp(0)      ,/* 資料創建日 */
dzepmodid       varchar2(20)      ,/* 資料修改者 */
dzepmoddt       timestamp(0)      ,/* 最近修改日 */
dzepcnfid       varchar2(20)      ,/* 資料確認者 */
dzepcnfdt       timestamp(0)      ,/* 資料確認日 */
dzep027       number(10,0)      ,/* 報表長度 */
dzep028       varchar2(10)      /* 報表數值格式 */
);
alter table dzep_t add constraint dzep_pk primary key (dzep001,dzep002) enable validate;

create unique index dzep_pk on dzep_t (dzep001,dzep002);

grant select on dzep_t to tiptop;
grant update on dzep_t to tiptop;
grant delete on dzep_t to tiptop;
grant insert on dzep_t to tiptop;

exit;
