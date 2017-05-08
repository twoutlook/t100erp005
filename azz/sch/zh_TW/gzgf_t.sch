/* 
================================================================================
檔案代號:gzgf_t
檔案名稱:XtraGrid報表樣板主檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table gzgf_t
(
gzgfstus       varchar2(10)      ,/* 狀態碼 */
gzgf000       varchar2(80)      ,/* 報表樣板ID */
gzgf001       varchar2(20)      ,/* 報表元件代號 */
gzgf002       varchar2(20)      ,/* 樣板代號 */
gzgf003       varchar2(1)      ,/* 客製 */
gzgf004       varchar2(40)      ,/* 用戶 */
gzgf005       varchar2(10)      ,/* 角色 */
gzgf006       varchar2(1)      ,/* 報表型態 */
gzgf007       varchar2(1)      ,/* 風格主題 */
gzgf008       varchar2(1)      ,/* 預設樣板 */
gzgf009       varchar2(1)      ,/* 列印簽核 */
gzgf010       varchar2(1)      ,/* 簽核位置 */
gzgf011       number(5,0)      ,/* 報表執行逾期時間(分) */
gzgf012       varchar2(1)      ,/* 中越樣板 */
gzgf013       varchar2(1)      ,/* 圖表軸數 */
gzgf014       varchar2(500)      ,/* 群組欄位 */
gzgf015       varchar2(500)      ,/* 排序欄位 */
gzgf016       varchar2(500)      ,/* 跳頁欄位 */
gzgf017       varchar2(500)      ,/* 輸出設定 */
gzgf018       varchar2(500)      ,/* 排序方式 */
gzgfownid       varchar2(20)      ,/* 資料所有者 */
gzgfowndp       varchar2(10)      ,/* 資料所屬部門 */
gzgfcrtid       varchar2(20)      ,/* 資料建立者 */
gzgfcrtdp       varchar2(10)      ,/* 資料建立部門 */
gzgfcrtdt       timestamp(0)      ,/* 資料創建日 */
gzgfmodid       varchar2(20)      ,/* 資料修改者 */
gzgfmoddt       timestamp(0)      ,/* 最近修改日 */
gzgf019       varchar2(1)      ,/* 展開資料 */
gzgf020       varchar2(1)      ,/* 交叉表橫軸小計 */
gzgf021       varchar2(1)      ,/* 交叉表縱軸小計 */
gzgf022       varchar2(1)      ,/* 交叉表橫軸總計 */
gzgf023       varchar2(1)      /* 交叉表縱軸總計 */
);
alter table gzgf_t add constraint gzgf_pk primary key (gzgf000) enable validate;

create unique index gzgf_pk on gzgf_t (gzgf000);
create unique index gzgf_u on gzgf_t (gzgf001,gzgf002,gzgf003,gzgf004,gzgf005);

grant select on gzgf_t to tiptop;
grant update on gzgf_t to tiptop;
grant delete on gzgf_t to tiptop;
grant insert on gzgf_t to tiptop;

exit;
