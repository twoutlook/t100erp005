/* 
================================================================================
檔案代號:dzrf_t
檔案名稱:XtraGrid報表樣板主檔(備份)
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table dzrf_t
(
dzrfstus       varchar2(10)      ,/* 狀態碼 */
dzrf000       varchar2(80)      ,/* 報表樣板ID */
dzrf001       varchar2(20)      ,/* 報表元件代號 */
dzrf002       varchar2(20)      ,/* 樣板代號 */
dzrf003       varchar2(1)      ,/* 客製 */
dzrf004       varchar2(40)      ,/* 用戶 */
dzrf005       varchar2(10)      ,/* 角色 */
dzrf006       varchar2(1)      ,/* 報表型態 */
dzrf007       varchar2(1)      ,/* 風格主題 */
dzrf008       varchar2(1)      ,/* 預設樣板 */
dzrf009       varchar2(1)      ,/* 列印簽核 */
dzrf010       varchar2(1)      ,/* 簽核位置 */
dzrf011       number(5,0)      ,/* 報表執行逾期時間(分) */
dzrf012       varchar2(1)      ,/* 中越樣板 */
dzrf013       varchar2(1)      ,/* 圖表軸數 */
dzrf014       varchar2(500)      ,/* 群組欄位 */
dzrf015       varchar2(500)      ,/* 排序欄位 */
dzrf016       varchar2(500)      ,/* 跳頁欄位 */
dzrf017       varchar2(500)      ,/* 輸出設定 */
dzrf018       varchar2(500)      ,/* 排序方式 */
dzrfownid       varchar2(20)      ,/* 資料所有者 */
dzrfowndp       varchar2(10)      ,/* 資料所屬部門 */
dzrfcrtid       varchar2(20)      ,/* 資料建立者 */
dzrfcrtdp       varchar2(10)      ,/* 資料建立部門 */
dzrfcrtdt       timestamp(0)      ,/* 資料創建日 */
dzrfmodid       varchar2(20)      ,/* 資料修改者 */
dzrfmoddt       timestamp(0)      ,/* 最近修改日 */
dzrf019       varchar2(1)      ,/* 展開資料 */
dzrf020       varchar2(1)      ,/* 交叉表橫軸小計 */
dzrf021       varchar2(1)      ,/* 交叉表縱軸小計 */
dzrf022       varchar2(1)      ,/* 交叉表橫軸總計 */
dzrf023       varchar2(1)      /* 交叉表縱軸總計 */
);
alter table dzrf_t add constraint dzrf_pk primary key (dzrf000) enable validate;

create unique index dzrf_pk on dzrf_t (dzrf000);
create unique index dzrf_u on dzrf_t (dzrf001,dzrf002,dzrf003,dzrf004,dzrf005);

grant select on dzrf_t to tiptop;
grant update on dzrf_t to tiptop;
grant delete on dzrf_t to tiptop;
grant insert on dzrf_t to tiptop;

exit;
