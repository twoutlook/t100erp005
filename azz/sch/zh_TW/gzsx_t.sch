/* 
================================================================================
檔案代號:gzsx_t
檔案名稱:參數作業頁面設定表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table gzsx_t
(
gzsx001       varchar2(20)      ,/* 設定作業名稱 */
gzsx002       varchar2(80)      ,/* 分頁編號 */
gzsx003       varchar2(80)      ,/* 分項編號 */
gzsxownid       varchar2(20)      ,/* 資料所有者 */
gzsxowndp       varchar2(10)      ,/* 資料所屬部門 */
gzsxcrtid       varchar2(20)      ,/* 資料建立者 */
gzsxcrtdp       varchar2(10)      ,/* 資料建立部門 */
gzsxcrtdt       timestamp(0)      ,/* 資料創建日 */
gzsxmodid       varchar2(20)      ,/* 資料修改者 */
gzsxmoddt       timestamp(0)      ,/* 最近修改日 */
gzsxstus       varchar2(10)      ,/* 狀態碼 */
gzsx004       number(5,0)      ,/* 分頁序號 */
gzsx005       number(5,0)      ,/* 分項序號 */
gzsx006       varchar2(80)      /* 分頁圖標 */
);
alter table gzsx_t add constraint gzsx_pk primary key (gzsx001,gzsx002,gzsx003) enable validate;

create unique index gzsx_pk on gzsx_t (gzsx001,gzsx002,gzsx003);

grant select on gzsx_t to tiptop;
grant update on gzsx_t to tiptop;
grant delete on gzsx_t to tiptop;
grant insert on gzsx_t to tiptop;

exit;
