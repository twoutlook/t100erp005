/* 
================================================================================
檔案代號:pmcj_t
檔案名稱:供應商評核評核項目得分檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:S
多語系檔案:N
============.========================.==========================================
 */
create table pmcj_t
(
pmcjent       number(5)      ,/* 企業編號 */
pmcj001       varchar2(10)      ,/* 評核期別 */
pmcj002       varchar2(10)      ,/* 評核品類 */
pmcj003       varchar2(10)      ,/* 評核類別 */
pmcj004       varchar2(10)      ,/* 供應商編號 */
pmcj005       varchar2(10)      ,/* 評核項目 */
pmcj006       varchar2(10)      ,/* 評核部門 */
pmcj007       number(15,3)      /* 項目得分 */
);
alter table pmcj_t add constraint pmcj_pk primary key (pmcjent,pmcj001,pmcj002,pmcj003,pmcj004,pmcj005) enable validate;

create unique index pmcj_pk on pmcj_t (pmcjent,pmcj001,pmcj002,pmcj003,pmcj004,pmcj005);

grant select on pmcj_t to tiptop;
grant update on pmcj_t to tiptop;
grant delete on pmcj_t to tiptop;
grant insert on pmcj_t to tiptop;

exit;
