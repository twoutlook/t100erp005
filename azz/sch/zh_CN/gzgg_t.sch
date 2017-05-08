/* 
================================================================================
檔案代號:gzgg_t
檔案名稱:XtraGrid報表樣板明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table gzgg_t
(
gzgg000       varchar2(80)      ,/* 報表樣板ID */
gzgg001       varchar2(40)      ,/* 報表欄位代碼 */
gzgg002       varchar2(6)      ,/* 語言別 */
gzgg003       varchar2(1)      ,/* 欄位型態 */
gzgg004       number(5,0)      ,/* 欄位順序 */
gzgg005       number(15,3)      ,/* 欄位寬度 */
gzgg006       varchar2(1)      ,/* 顯示 */
gzgg007       varchar2(1)      ,/* 位置 */
gzgg008       varchar2(4)      ,/* 小數位顯示位數 */
gzgg009       varchar2(1)      ,/* 群組摘要(小計)選項 */
gzgg010       varchar2(1)      ,/* 報表摘要(總計)選項 */
gzgg011       varchar2(40)      ,/* 條件隱藏欄位 */
gzgg012       varchar2(1)      ,/* 可設為條件隱藏欄位 */
gzgg013       varchar2(1)      ,/* 縮排 */
gzgg014       number(5,0)      ,/* 交叉表橫軸順序 */
gzgg015       number(5,0)      ,/* 交叉表縱軸順序 */
gzgg016       number(5,0)      ,/* 交叉表資料區順序 */
gzgg017       varchar2(1)      ,/* 子報表欄位否/父節點 */
gzgg018       varchar2(40)      ,/* 與主報表關聯欄位/子節點 */
gzgg019       varchar2(1)      ,/* 報表樣板區段 */
gzgg020       varchar2(1)      ,/* 圖表類型 */
gzgg021       number(5,0)      ,/* 圖表欄位順序 */
gzgg022       number(5,0)      ,/* 分類欄位(X軸) */
gzgg023       varchar2(1)      ,/* 自訂欄位 */
gzgg024       varchar2(2000)      ,/* 自訂欄位公式 */
gzgg025       varchar2(15)      ,/* 資料表別名 */
gzgg026       varchar2(40)      ,/* 欄位別名 */
gzgg027       number(5,0)      ,/* 行序 */
gzgg028       varchar2(500)      /* 交叉表彙總自定公式 */
);
alter table gzgg_t add constraint gzgg_pk primary key (gzgg000,gzgg001,gzgg002) enable validate;

create unique index gzgg_pk on gzgg_t (gzgg000,gzgg001,gzgg002);

grant select on gzgg_t to tiptop;
grant update on gzgg_t to tiptop;
grant delete on gzgg_t to tiptop;
grant insert on gzgg_t to tiptop;

exit;
