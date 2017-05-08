/* 
================================================================================
檔案代號:gzbbl_t
檔案名稱:節點的多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:Y
============.========================.==========================================
 */
create table gzbbl_t
(
gzbbl001       varchar2(20)      ,/* 節點代號 */
gzbbl002       varchar2(6)      ,/* 語系 */
gzbbl003       varchar2(500)      ,/* 說明(簡稱) */
gzbblent       number(5)      ,/* 企業碼 */
gzbbl004       varchar2(500)      /* 文字描述 */
);
alter table gzbbl_t add constraint gzbbl_pk primary key (gzbbl001,gzbbl002,gzbblent) enable validate;

create unique index gzbbl_pk on gzbbl_t (gzbbl001,gzbbl002,gzbblent);

grant select on gzbbl_t to tiptop;
grant update on gzbbl_t to tiptop;
grant delete on gzbbl_t to tiptop;
grant insert on gzbbl_t to tiptop;

exit;
