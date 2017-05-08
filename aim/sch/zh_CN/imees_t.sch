/* 
================================================================================
檔案代號:imees_t
檔案名稱:規則化品名種類提速檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:V
多語系檔案:N
============.========================.==========================================
 */
create table imees_t
(
imeesent       number(5)      ,/* 企業編號 */
imees001       varchar2(10)      ,/* 品名種類 */
imees002       varchar2(10)      ,/* 節點編號 */
imees003       varchar2(40)      ,/* 提速值 */
imees004       number(5,0)      /* 階層 */
);
alter table imees_t add constraint imees_pk primary key (imeesent,imees001,imees002,imees003) enable validate;

create  index imees_01 on imees_t (imeesent,imees001,imees003,imees004);
create  index imees_02 on imees_t (imeesent,imees001,imees002);
create unique index imees_pk on imees_t (imeesent,imees001,imees002,imees003);

grant select on imees_t to tiptop;
grant update on imees_t to tiptop;
grant delete on imees_t to tiptop;
grant insert on imees_t to tiptop;

exit;
