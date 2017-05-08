/* 
================================================================================
檔案代號:nmbes_t
檔案名稱:收支項目對應存提碼資料檔提速檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:V
多語系檔案:N
============.========================.==========================================
 */
create table nmbes_t
(
nmbesent       number(5)      ,/* 企業編號 */
nmbes001       varchar2(10)      ,/* 收支項目版本 */
nmbes002       varchar2(10)      ,/* 收支項目代碼 */
nmbes003       varchar2(10)      ,/* 存提碼 */
nmbes004       varchar2(40)      ,/* 提速值 */
nmbes005       number(5,0)      /* 階層 */
);
alter table nmbes_t add constraint nmbes_pk primary key (nmbesent,nmbes001,nmbes002,nmbes003,nmbes004) enable validate;

create unique index nmbes_pk on nmbes_t (nmbesent,nmbes001,nmbes002,nmbes003,nmbes004);

grant select on nmbes_t to tiptop;
grant update on nmbes_t to tiptop;
grant delete on nmbes_t to tiptop;
grant insert on nmbes_t to tiptop;

exit;
