/* 
================================================================================
檔案代號:pmbal_t
檔案名稱:交易對象准入檔多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table pmbal_t
(
pmbalent       number(5)      ,/* 企業編號 */
pmbaldocno       varchar2(20)      ,/* 申請單號 */
pmbal001       varchar2(6)      ,/* 語言別 */
pmbal002       varchar2(255)      ,/* 交易對象全名 */
pmbal003       varchar2(80)      ,/* 交易對象簡稱 */
pmbal004       varchar2(10)      ,/* 助記碼 */
pmbal005       varchar2(255)      /* 交易對象全名二 */
);
alter table pmbal_t add constraint pmbal_pk primary key (pmbalent,pmbaldocno,pmbal001) enable validate;

create  index pmbal_01 on pmbal_t (pmbal004);
create unique index pmbal_pk on pmbal_t (pmbalent,pmbaldocno,pmbal001);

grant select on pmbal_t to tiptop;
grant update on pmbal_t to tiptop;
grant delete on pmbal_t to tiptop;
grant insert on pmbal_t to tiptop;

exit;
