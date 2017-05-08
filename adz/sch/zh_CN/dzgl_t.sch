/* 
================================================================================
檔案代號:dzgl_t
檔案名稱:報表元件設計-樣板明細檔(XG)
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table dzgl_t
(
dzgl001       varchar2(20)      ,/* 報表元件代號 */
dzgl002       number(10)      ,/* 版次 */
dzgl003       varchar2(20)      ,/* 樣板代號 */
dzgl004       number(5,0)      ,/* 欄位順序 */
dzgl005       varchar2(40)      ,/* 報表欄位代碼 */
dzgl006       varchar2(1)      ,/* 欄位型態 */
dzgl007       number(15,3)      ,/* 欄位寬度 */
dzgl008       varchar2(1)      ,/* 顯示 */
dzgl009       varchar2(1)      ,/* 位置 */
dzgl010       varchar2(4)      ,/* 小數位顯示位數 */
dzgl011       varchar2(1)      ,/* 群組摘要(小計)選項 */
dzgl012       varchar2(1)      ,/* 報表摘要(總計)選項 */
dzgl013       varchar2(40)      ,/* 條件隱藏欄位 */
dzgl014       varchar2(1)      ,/* 可設為條件隱藏欄位 */
dzgl015       varchar2(1)      ,/* 縮排 */
dzgl016       number(5,0)      ,/* 交叉表橫軸順序 */
dzgl017       number(5,0)      ,/* 交叉表縱軸順序 */
dzgl018       number(5,0)      ,/* 交叉表資料區順序 */
dzgl019       varchar2(1)      ,/* 主鍵/父節點欄位 */
dzgl020       varchar2(1)      ,/* 與主報表關聯鍵/自節點欄位 */
dzgl021       varchar2(1)      ,/* 報表樣板區段 */
dzgl022       varchar2(1)      ,/* 圖表類型 */
dzgl023       number(5,0)      ,/* 圖表欄位順序 */
dzgl024       number(5,0)      ,/* 分類欄位(X軸) */
dzgl025       varchar2(1)      ,/* 自訂欄位 */
dzgl026       varchar2(2000)      ,/* 自訂欄位公式 */
dzgl027       varchar2(15)      ,/* 表格別名 */
dzgl028       varchar2(40)      ,/* 欄位別名 */
dzgl029       varchar2(40)      ,/* 客戶代號 */
dzgl030       varchar2(1)      /* 客製 */
);
alter table dzgl_t add constraint dzgl_pk primary key (dzgl001,dzgl002,dzgl003,dzgl004,dzgl030) enable validate;

create unique index dzgl_pk on dzgl_t (dzgl001,dzgl002,dzgl003,dzgl004,dzgl030);

grant select on dzgl_t to tiptop;
grant update on dzgl_t to tiptop;
grant delete on dzgl_t to tiptop;
grant insert on dzgl_t to tiptop;

exit;
