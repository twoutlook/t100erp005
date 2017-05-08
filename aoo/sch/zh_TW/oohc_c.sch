/* 
================================================================================
檔案代號:oohc_c
檔案名稱:控制組人員檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table oohc_c
(
oohcent       number(5)      ,/* 企業代碼 */
oohcmodu       varchar2(10)      ,/* 資料修改者 */
oohcdate       date      ,/* 最近修改日 */
oohcoriu       varchar2(10)      ,/* 資料所有者 */
oohcorid       varchar2(10)      ,/* 資料所有部門 */
oohcuser       varchar2(10)      ,/* 資料建立者 */
oohcdept       varchar2(10)      ,/* 資料建立部門 */
oohcbuid       date      ,/* 資料創建日 */
oohcstus       varchar2(10)      ,/* 狀態碼 */
oohc001       varchar2(10)      ,/* 控制組編號 */
oohc002       varchar2(10)      ,/* 員工編號 */
oohc003       date      ,/* 生效日期 */
oohc004       date      /* 失效日期 */
);
alter table oohc_c add constraint oohc_pk primary key (oohcent,oohc001,oohc002) enable validate;

create  index oohc_01 on oohc_c (oohc003);
create  index oohc_02 on oohc_c (oohc004);

grant select on oohc_c to tiptop;
grant update on oohc_c to tiptop;
grant delete on oohc_c to tiptop;
grant insert on oohc_c to tiptop;

exit;
