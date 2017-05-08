/* 
================================================================================
檔案代號:oojn_t
檔案名稱:報表郵件預設收件人單身檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table oojn_t
(
oojnent       number(5)      ,/* 企業編號 */
oojn001       varchar2(20)      ,/* 作業編號 */
oojn002       number(5,0)      ,/* 序號 */
oojn003       varchar2(40)      ,/* 收件人員工編號 */
oojn004       varchar2(80)      ,/* 收件者名稱 */
oojn005       varchar2(1)      ,/* 形式 */
oojn006       varchar2(80)      ,/* E-mail Address */
oojn007       varchar2(1)      ,/* 報表mail檔案格式 */
oojn008       varchar2(255)      ,/* 備註 */
oojn009       varchar2(20)      ,/* 用戶 */
oojn010       varchar2(10)      ,/* 角色 */
oojn011       varchar2(10)      /* 聯絡對象類型 */
);
alter table oojn_t add constraint oojn_pk primary key (oojnent,oojn001,oojn002,oojn009,oojn010) enable validate;

create unique index oojn_pk on oojn_t (oojnent,oojn001,oojn002,oojn009,oojn010);

grant select on oojn_t to tiptop;
grant update on oojn_t to tiptop;
grant delete on oojn_t to tiptop;
grant insert on oojn_t to tiptop;

exit;
