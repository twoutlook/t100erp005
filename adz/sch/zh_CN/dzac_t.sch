/* 
================================================================================
檔案代號:dzac_t
檔案名稱:欄位規格設計表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table dzac_t
(
dzacstus       varchar2(10)      ,/* no use */
dzac001       varchar2(20)      ,/* 規格編號 */
dzac002       varchar2(20)      ,/* 欄位編號 */
dzac003       varchar2(60)      ,/* 控件名稱 */
dzac004       number(10)      ,/* 識別碼版次 */
dzac005       varchar2(15)      ,/* Table編號 */
dzac006       varchar2(4)      ,/* no use */
dzac007       varchar2(20)      ,/* no use */
dzac008       varchar2(1)      ,/* 必要欄位 */
dzac009       varchar2(20)      ,/* 編輯時開窗 */
dzac010       varchar2(20)      ,/* 查詢時開窗 */
dzac011       varchar2(500)      ,/* 校驗帶值設定 */
dzac012       varchar2(1)      ,/* 使用標示 */
dzac013       varchar2(40)      ,/* 客戶代號 */
dzac014       varchar2(100)      ,/* 預設值 */
dzac015       varchar2(80)      ,/* 最大值 */
dzac016       varchar2(80)      ,/* 最小值 */
dzac017       varchar2(1)      ,/* 是否可編輯 */
dzac018       varchar2(1)      ,/* 是否可查詢 */
dzac019       varchar2(40)      ,/* 顯現控件 */
dzac099       clob      ,/* 規格內容 */
dzac020       varchar2(40)      ,/* 最大值運算子 */
dzac021       varchar2(15)      ,/* 最小值運算子 */
dzacownid       varchar2(20)      ,/* 資料所有者 */
dzacowndp       varchar2(10)      ,/* 資料所屬部門 */
dzaccrtid       varchar2(20)      ,/* 資料建立者 */
dzaccrtdp       varchar2(10)      ,/* 資料建立部門 */
dzaccrtdt       timestamp(0)      ,/* 資料創建日 */
dzacmodid       varchar2(20)      ,/* 資料修改者 */
dzacmoddt       timestamp(0)      /* 最近修改日 */
);
alter table dzac_t add constraint dzac_pk primary key (dzac001,dzac003,dzac004,dzac012) enable validate;

create unique index dzac_pk on dzac_t (dzac001,dzac003,dzac004,dzac012);

grant select on dzac_t to tiptop;
grant update on dzac_t to tiptop;
grant delete on dzac_t to tiptop;
grant insert on dzac_t to tiptop;

exit;
