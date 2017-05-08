/* 
================================================================================
檔案代號:imbal_t
檔案名稱:商品准入/料件申請單主檔多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table imbal_t
(
imbalent       number(5)      ,/* 企業編號 */
imbaldocno       varchar2(20)      ,/* 申請單號 */
imbal001       varchar2(6)      ,/* 語系 */
imbal002       varchar2(255)      ,/* 品名 */
imbal003       varchar2(255)      ,/* 規格 */
imbal004       varchar2(10)      /* 助記碼 */
);
alter table imbal_t add constraint imbal_pk primary key (imbalent,imbaldocno,imbal001) enable validate;

create  index imbal_01 on imbal_t (imbal004);
create unique index imbal_pk on imbal_t (imbalent,imbaldocno,imbal001);

grant select on imbal_t to tiptop;
grant update on imbal_t to tiptop;
grant delete on imbal_t to tiptop;
grant insert on imbal_t to tiptop;

exit;
