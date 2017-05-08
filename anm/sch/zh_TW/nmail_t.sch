/* 
================================================================================
檔案代號:nmail_t
檔案名稱:現金異動碼表檔多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table nmail_t
(
nmailent       number(5)      ,/* 企業編號 */
nmail001       varchar2(5)      ,/* 現金異動碼表 */
nmail002       varchar2(10)      ,/* 現金異動碼 */
nmail003       varchar2(6)      ,/* 語言別 */
nmail004       varchar2(500)      /* 說明 */
);
alter table nmail_t add constraint nmail_pk primary key (nmailent,nmail001,nmail002,nmail003) enable validate;

create unique index nmail_pk on nmail_t (nmailent,nmail001,nmail002,nmail003);

grant select on nmail_t to tiptop;
grant update on nmail_t to tiptop;
grant delete on nmail_t to tiptop;
grant insert on nmail_t to tiptop;

exit;
