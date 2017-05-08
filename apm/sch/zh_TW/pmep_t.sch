/* 
================================================================================
檔案代號:pmep_t
檔案名稱:採購合約結算歷程檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table pmep_t
(
pmepent       number(5)      ,/* 企業編號 */
pmepsite       varchar2(10)      ,/* 營運據點 */
pmep001       varchar2(20)      ,/* 合約單號 */
pmep002       number(10,0)      ,/* 項次 */
pmep003       timestamp(0)      ,/* 結算日期 */
pmep004       number(20,6)      ,/* 本期新增數量 */
pmep005       number(20,6)      ,/* 本期新增未稅金額 */
pmep006       number(20,6)      ,/* 本期新增含稅金額 */
pmep007       number(20,6)      ,/* 本期新增稅額 */
pmep008       number(20,6)      ,/* 本期累積數量 */
pmep009       number(20,6)      ,/* 本期累積未稅金額 */
pmep010       number(20,6)      ,/* 本期累積含稅金額 */
pmep011       number(20,6)      ,/* 本期累積稅額 */
pmep012       varchar2(20)      ,/* 結算人員 */
pmep013       varchar2(10)      /* 結算部門 */
);
alter table pmep_t add constraint pmep_pk primary key (pmepent,pmep001,pmep002,pmep003) enable validate;

create unique index pmep_pk on pmep_t (pmepent,pmep001,pmep002,pmep003);

grant select on pmep_t to tiptop;
grant update on pmep_t to tiptop;
grant delete on pmep_t to tiptop;
grant insert on pmep_t to tiptop;

exit;
