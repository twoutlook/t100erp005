/* 
================================================================================
檔案代號:ooek_t
檔案名稱:報表Logo紀錄檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table ooek_t
(
ooekstus       varchar2(10)      ,/* 狀態碼 */
ooekent       number(5)      ,/* 企業編號 */
ooek001       varchar2(10)      ,/* 組織編號 */
ooek002       varchar2(6)      ,/* 語言別 */
ooek003       blob      ,/* logo圖片 */
ooek004       varchar2(1)      ,/* 列印國家地區 */
ooek005       varchar2(1)      ,/* 列印州/省/直轄市 */
ooekownid       varchar2(20)      ,/* 資料所有者 */
ooekowndp       varchar2(10)      ,/* 資料所屬部門 */
ooekcrtid       varchar2(20)      ,/* 資料建立者 */
ooekcrtdp       varchar2(10)      ,/* 資料建立部門 */
ooekcrtdt       timestamp(0)      ,/* 資料創建日 */
ooekmodid       varchar2(20)      ,/* 資料修改者 */
ooekmoddt       timestamp(0)      /* 最近修改日 */
);
alter table ooek_t add constraint ooek_pk primary key (ooekent,ooek001,ooek002) enable validate;


grant select on ooek_t to tiptop;
grant update on ooek_t to tiptop;
grant delete on ooek_t to tiptop;
grant insert on ooek_t to tiptop;

exit;
