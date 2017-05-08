/* 
================================================================================
檔案代號:gzha_t
檔案名稱:GWC佈景檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table gzha_t
(
gzhaownid       varchar2(20)      ,/* 資料所有者 */
gzhaowndp       varchar2(10)      ,/* 資料所屬部門 */
gzhacrtid       varchar2(20)      ,/* 資料建立者 */
gzhacrtdp       varchar2(10)      ,/* 資料建立部門 */
gzhacrtdt       timestamp(0)      ,/* 資料創建日 */
gzhamodid       varchar2(20)      ,/* 資料修改者 */
gzhamoddt       timestamp(0)      ,/* 最近修改日 */
gzhastus       varchar2(10)      ,/* 狀態碼 */
gzha001       varchar2(40)      /* 佈景編號 */
);
alter table gzha_t add constraint gzha_pk primary key (gzha001) enable validate;

create unique index gzha_pk on gzha_t (gzha001);

grant select on gzha_t to tiptop;
grant update on gzha_t to tiptop;
grant delete on gzha_t to tiptop;
grant insert on gzha_t to tiptop;

exit;
