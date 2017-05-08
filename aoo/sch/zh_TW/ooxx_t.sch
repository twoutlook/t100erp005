/* 
================================================================================
檔案代號:ooxx_t
檔案名稱: 
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table ooxx_t
(
ooxxmodu       varchar2(80)      ,/* 資料修改者 */
ooxxdate       varchar2(80)      ,/* 最近修改日 */
ooxxoriu       varchar2(10)      ,/* 資料所有者 */
ooxxorid       varchar2(10)      ,/* 資料所有部門 */
ooxxuser       varchar2(30)      ,/* 資料建立者 */
ooxxdept       varchar2(30)      ,/* 資料建立部門 */
ooxxbuid       varchar2(500)      ,/* 資料創建日 */
ooxxstus       varchar2(255)      ,/* 有效碼 */
ooxxent       varchar2(1)      ,/* 企業編號 */
ooxx001       varchar2(10)      ,/* 營運據點 */
ooxx002       varchar2(40)      ,/* 上層營運據點 */
ooxx003       varchar2(10)      ,/* 法人否 */
ooxx004       varchar2(10)      ,/* 主帳套編號 */
ooxx005       varchar2(10)      ,/* 單別參照表編號 */
ooxx006       varchar2(10)      ,/* 單號區分碼簡編 */
ooxx007       varchar2(10)      ,/* 時區 */
ooxx008       varchar2(10)      ,/* 國家地區 */
ooxx009       varchar2(10)      ,/* 州省 */
ooxx010       varchar2(20)      ,/* 縣市 */
ooxx011       varchar2(10)      ,/* 行政地區 */
ooxx012       varchar2(10)      ,/* 電話 */
ooxx013       varchar2(20)      /* 傳真 */
);
alter table ooxx_t add constraint ooxx_pk primary key (ooxx002,ooxx003) enable validate;


grant select on ooxx_t to tiptop;
grant update on ooxx_t to tiptop;
grant delete on ooxx_t to tiptop;
grant insert on ooxx_t to tiptop;

exit;
