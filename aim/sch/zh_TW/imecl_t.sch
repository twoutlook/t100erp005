/* 
================================================================================
檔案代號:imecl_t
檔案名稱:料件特徵群組特徵值多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table imecl_t
(
imeclent       number(5)      ,/* 企業編號 */
imecl001       varchar2(40)      ,/* 特徵群組代碼 */
imecl002       number(10,0)      ,/* 單身項次 */
imecl003       varchar2(30)      ,/* 特徵值 */
imecl004       varchar2(6)      ,/* 語言別 */
imecl005       varchar2(500)      ,/* 說明 */
imecl006       varchar2(10)      /* 助記碼 */
);
alter table imecl_t add constraint imecl_pk primary key (imeclent,imecl001,imecl002,imecl003,imecl004) enable validate;

create  index imecl_01 on imecl_t (imecl006);
create unique index imecl_pk on imecl_t (imeclent,imecl001,imecl002,imecl003,imecl004);

grant select on imecl_t to tiptop;
grant update on imecl_t to tiptop;
grant delete on imecl_t to tiptop;
grant insert on imecl_t to tiptop;

exit;
