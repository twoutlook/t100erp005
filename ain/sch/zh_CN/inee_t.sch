/* 
================================================================================
檔案代號:inee_t
檔案名稱:預盤商品清單資料表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table inee_t
(
ineeent       number(5)      ,/* 企業編號 */
ineeunit       varchar2(10)      ,/* 應用組織 */
ineesite       varchar2(10)      ,/* 營運據點 */
inee001       varchar2(20)      ,/* 盤點計劃 */
inee002       varchar2(40)      ,/* 商品編號 */
inee003       number(20,6)      ,/* 最新進價 */
inee004       number(20,6)      /* 售價 */
);
alter table inee_t add constraint inee_pk primary key (ineeent,ineesite,inee001,inee002) enable validate;

create unique index inee_pk on inee_t (ineeent,ineesite,inee001,inee002);

grant select on inee_t to tiptop;
grant update on inee_t to tiptop;
grant delete on inee_t to tiptop;
grant insert on inee_t to tiptop;

exit;
