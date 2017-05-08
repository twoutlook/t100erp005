/* 
================================================================================
檔案代號:gzgd_t
檔案名稱:GR報表樣板主檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table gzgd_t
(
gzgdstus       varchar2(10)      ,/* 狀態碼 */
gzgd000       varchar2(80)      ,/* 報表樣板ID */
gzgd001       varchar2(20)      ,/* 報表元件代號 */
gzgd002       varchar2(20)      ,/* 樣板代號 */
gzgd003       varchar2(1)      ,/* 客製 */
gzgd004       varchar2(40)      ,/* 角色 */
gzgd005       varchar2(10)      ,/* 用戶 */
gzgd006       number(10,0)      ,/* 序號 */
gzgd007       varchar2(40)      ,/* 樣板名稱(4rp) */
gzgd008       varchar2(1)      ,/* 預設樣板 */
gzgd009       varchar2(1)      ,/* 列印簽核 */
gzgd010       varchar2(1)      ,/* 簽核位置 */
gzgd011       number(5,0)      ,/* 報表執行逾期時間(分) */
gzgd012       varchar2(1)      ,/* 中越樣板 */
gzgd013       varchar2(100)      ,/* 客戶紙張 */
gzgdownid       varchar2(20)      ,/* 資料所有者 */
gzgdowndp       varchar2(10)      ,/* 資料所屬部門 */
gzgdcrtid       varchar2(20)      ,/* 資料建立者 */
gzgdcrtdp       varchar2(10)      ,/* 資料建立部門 */
gzgdcrtdt       timestamp(0)      ,/* 資料創建日 */
gzgdmodid       varchar2(20)      ,/* 資料修改者 */
gzgdmoddt       timestamp(0)      ,/* 最近修改日 */
gzgd014       varchar2(1)      /* 表頭位置 */
);
alter table gzgd_t add constraint gzgd_pk primary key (gzgd000) enable validate;

create unique index gzgd_pk on gzgd_t (gzgd000);
create unique index gzgd_u on gzgd_t (gzgd001,gzgd002,gzgd003,gzgd004,gzgd005,gzgd006);

grant select on gzgd_t to tiptop;
grant update on gzgd_t to tiptop;
grant delete on gzgd_t to tiptop;
grant insert on gzgd_t to tiptop;

exit;
