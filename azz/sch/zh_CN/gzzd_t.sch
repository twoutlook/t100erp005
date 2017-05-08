/* 
================================================================================
檔案代號:gzzd_t
檔案名稱:畫面元件多語言記錄表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:Y
============.========================.==========================================
 */
create table gzzd_t
(
gzzdstus       varchar2(10)      ,/* 狀態碼 */
gzzd001       varchar2(20)      ,/* 畫面編號 */
gzzd002       varchar2(6)      ,/* 語言別 */
gzzd003       varchar2(80)      ,/* 待轉標籤 */
gzzd004       varchar2(1)      ,/* 使用標示 */
gzzd005       varchar2(255)      ,/* 轉換標籤文字 */
gzzd006       varchar2(255)      ,/* 轉換註解 */
gzzdownid       varchar2(20)      ,/* 資料所有者 */
gzzdowndp       varchar2(10)      ,/* 資料所屬部門 */
gzzdcrtid       varchar2(20)      ,/* 資料建立者 */
gzzdcrtdp       varchar2(10)      ,/* 資料建立部門 */
gzzdcrtdt       timestamp(0)      ,/* 資料創建日 */
gzzdmodid       varchar2(20)      ,/* 資料修改者 */
gzzdmoddt       timestamp(0)      /* 最近修改日 */
);
alter table gzzd_t add constraint gzzd_pk primary key (gzzd001,gzzd002,gzzd003,gzzd004) enable validate;

create unique index gzzd_pk on gzzd_t (gzzd001,gzzd002,gzzd003,gzzd004);

grant select on gzzd_t to tiptop;
grant update on gzzd_t to tiptop;
grant delete on gzzd_t to tiptop;
grant insert on gzzd_t to tiptop;

exit;
