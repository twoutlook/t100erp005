/* 
================================================================================
檔案代號:dzrg_t
檔案名稱:XtraGrid報表樣板明細檔(備份)
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table dzrg_t
(
dzrg000       varchar2(80)      ,/* 報表樣板ID */
dzrg001       varchar2(40)      ,/* 報表欄位代碼 */
dzrg002       varchar2(6)      ,/* 語言別 */
dzrg003       varchar2(1)      ,/* 欄位型態 */
dzrg004       number(5,0)      ,/* 欄位順序 */
dzrg005       number(15,3)      ,/* 欄位寬度 */
dzrg006       varchar2(1)      ,/* 顯示 */
dzrg007       varchar2(1)      ,/* 位置 */
dzrg008       varchar2(4)      ,/* 小數位顯示位數 */
dzrg009       varchar2(1)      ,/* 群組摘要(小計)選項 */
dzrg010       varchar2(1)      ,/* 報表摘要(總計)選項 */
dzrg011       varchar2(40)      ,/* 條件隱藏欄位 */
dzrg012       varchar2(1)      ,/* 可設為條件隱藏欄位 */
dzrg013       varchar2(1)      ,/* 縮排 */
dzrg014       number(5,0)      ,/* 交叉表橫軸順序 */
dzrg015       number(5,0)      ,/* 交叉表縱軸順序 */
dzrg016       number(5,0)      ,/* 交叉表資料區順序 */
dzrg017       varchar2(1)      ,/* 子報表欄位否/父節點 */
dzrg018       varchar2(40)      ,/* 與主報表關聯欄位/子節點 */
dzrg019       varchar2(1)      ,/* 報表樣板區段 */
dzrg020       varchar2(1)      ,/* 圖表類型 */
dzrg021       number(5,0)      ,/* 圖表欄位順序 */
dzrg022       number(5,0)      ,/* 分類欄位(X軸) */
dzrg023       varchar2(1)      ,/* 自訂欄位 */
dzrg024       varchar2(2000)      ,/* 自訂欄位公式 */
dzrg025       varchar2(15)      ,/* 資料表別名 */
dzrg026       varchar2(40)      ,/* 欄位別名 */
dzrg027       number(5,0)      ,/* 行序 */
dzrg028       varchar2(500)      /* 交叉表彙總自定公式 */
);
alter table dzrg_t add constraint dzrg_pk primary key (dzrg000,dzrg001,dzrg002) enable validate;

create unique index dzrg_pk on dzrg_t (dzrg000,dzrg001,dzrg002);

grant select on dzrg_t to tiptop;
grant update on dzrg_t to tiptop;
grant delete on dzrg_t to tiptop;
grant insert on dzrg_t to tiptop;

exit;
