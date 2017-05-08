/* 
================================================================================
檔案代號:decd_t
檔案名稱:會員卡積點日結檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:S
多語系檔案:N
============.========================.==========================================
 */
create table decd_t
(
decdent       number(5)      ,/* 企業編號 */
decd001       varchar2(10)      ,/* 卡種 */
decd002       date      ,/* 異動日期 */
decd003       number(22,2)      ,/* 本日期初點數 */
decd004       number(22,2)      ,/* 本日新增點數 */
decd005       number(22,2)      ,/* 本日使用點數 */
decd006       number(22,2)      ,/* 本日失效點數 */
decd007       number(22,2)      ,/* 本日期末點數 */
decd008       varchar2(20)      ,/* 日結人員 */
decd009       timestamp(0)      /* 日結日期 */
);
alter table decd_t add constraint decd_pk primary key (decdent,decd001,decd002) enable validate;

create unique index decd_pk on decd_t (decdent,decd001,decd002);

grant select on decd_t to tiptop;
grant update on decd_t to tiptop;
grant delete on decd_t to tiptop;
grant insert on decd_t to tiptop;

exit;
