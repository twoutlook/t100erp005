/* 
================================================================================
檔案代號:dzlu_t
檔案名稱:簽出權限
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table dzlu_t
(
dzlu001       varchar2(2)      ,/* 角色 */
dzlu002       varchar2(20)      ,/* 工號 */
dzlu003       varchar2(20)      ,/* 需求單號 */
dzlu004       varchar2(10)      ,/* 產品代號 */
dzlu005       varchar2(10)      ,/* 產品版本 */
dzlu006       number(5,0)      ,/* 作業項次 */
dzlu007       varchar2(40)      ,/* NO USE */
dzlu008       varchar2(10)      ,/* 作業類型 */
dzlu009       varchar2(255)      /* 作業代號 */
);
alter table dzlu_t add constraint dzlu_pk primary key (dzlu001,dzlu003,dzlu004,dzlu005,dzlu006) enable validate;

create unique index dzlu_pk on dzlu_t (dzlu001,dzlu003,dzlu004,dzlu005,dzlu006);

grant select on dzlu_t to tiptop;
grant update on dzlu_t to tiptop;
grant delete on dzlu_t to tiptop;
grant insert on dzlu_t to tiptop;

exit;
