/* 
================================================================================
檔案代號:infq_t
檔案名稱:貨架位置商品關係表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table infq_t
(
infqent       number(5)      ,/* 企業代碼 */
infqsite       varchar2(10)      ,/* 營運據點 */
infq001       varchar2(10)      ,/* 庫區編號 */
infq002       varchar2(40)      ,/* 貨架位置 */
infq003       varchar2(40)      /* 商品編號 */
);
alter table infq_t add constraint infq_pk primary key (infqent,infqsite,infq001,infq002) enable validate;

create unique index infq_pk on infq_t (infqent,infqsite,infq001,infq002);

grant select on infq_t to tiptop;
grant update on infq_t to tiptop;
grant delete on infq_t to tiptop;
grant insert on infq_t to tiptop;

exit;
