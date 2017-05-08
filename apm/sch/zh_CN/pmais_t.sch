/* 
================================================================================
檔案代號:pmais_t
檔案名稱:供應商不良記錄檔提速檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:V
多語系檔案:N
============.========================.==========================================
 */
create table pmais_t
(
pmaisent       number(5)      ,/* 企業編號 */
pmais001       varchar2(10)      ,/* 供應商編號 */
pmais002       number(10,0)      ,/* 序號 */
pmais003       varchar2(40)      ,/* 提速值 */
pmais004       number(5,0)      /* 階層 */
);
alter table pmais_t add constraint pmais_pk primary key (pmaisent,pmais001,pmais002,pmais003) enable validate;

create unique index pmais_pk on pmais_t (pmaisent,pmais001,pmais002,pmais003);

grant select on pmais_t to tiptop;
grant update on pmais_t to tiptop;
grant delete on pmais_t to tiptop;
grant insert on pmais_t to tiptop;

exit;
