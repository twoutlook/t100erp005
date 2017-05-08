/* 
================================================================================
檔案代號:pmaal_t
檔案名稱:交易對象主檔多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table pmaal_t
(
pmaalent       number(5)      ,/* 企業編號 */
pmaal001       varchar2(10)      ,/* 交易對象編號 */
pmaal002       varchar2(6)      ,/* 語言別 */
pmaal003       varchar2(255)      ,/* 交易對象全名 */
pmaal004       varchar2(80)      ,/* 交易對象簡稱 */
pmaal005       varchar2(10)      ,/* 助記碼 */
pmaal006       varchar2(255)      /* 交易對象全名二 */
);
alter table pmaal_t add constraint pmaal_pk primary key (pmaalent,pmaal001,pmaal002) enable validate;

create  index pmaal_01 on pmaal_t (pmaal005);
create unique index pmaal_pk on pmaal_t (pmaalent,pmaal001,pmaal002);

grant select on pmaal_t to tiptop;
grant update on pmaal_t to tiptop;
grant delete on pmaal_t to tiptop;
grant insert on pmaal_t to tiptop;

exit;
