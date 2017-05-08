/* 
================================================================================
檔案代號:gztd_t
檔案名稱:欄位屬性定義檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table gztd_t
(
gztdstus       varchar2(10)      ,/* 狀態碼 */
gztd001       varchar2(4)      ,/* 欄位屬性編號 */
gztd002       varchar2(40)      ,/* 屬性簡稱 */
gztd003       varchar2(20)      ,/* 資料型態 */
gztd004       varchar2(500)      ,/* 說明 */
gztd005       varchar2(20)      ,/* 資料控制項 */
gztd006       varchar2(1)      ,/* 客製 */
gztd007       varchar2(40)      ,/* 顯示格式 */
gztd008       varchar2(10)      ,/* 長度 */
gztd009       varchar2(20)      ,/* Genero 資料型態 */
gztd010       number(10,0)      ,/* 畫面長度 */
gztdownid       varchar2(20)      ,/* 資料所有者 */
gztdowndp       varchar2(10)      ,/* 資料所屬部門 */
gztdcrtid       varchar2(20)      ,/* 資料建立者 */
gztdcrtdp       varchar2(10)      ,/* 資料建立部門 */
gztdcrtdt       timestamp(0)      ,/* 資料創建日 */
gztdmodid       varchar2(20)      ,/* 資料修改者 */
gztdmoddt       timestamp(0)      ,/* 最近修改日 */
gztd011       number(10,0)      ,/* 報表長度 */
gztd012       varchar2(10)      ,/* 報表數值格式 */
gztd013       varchar2(10)      ,/* 欄位大小寫 */
gztd014       varchar2(40)      ,/* 憑證報表欄位格式 */
gztd015       varchar2(40)      /* 查詢報表欄位格式 */
);
alter table gztd_t add constraint gztd_pk primary key (gztd001) enable validate;

create unique index gztd_pk on gztd_t (gztd001);

grant select on gztd_t to tiptop;
grant update on gztd_t to tiptop;
grant delete on gztd_t to tiptop;
grant insert on gztd_t to tiptop;

exit;
