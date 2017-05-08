/* 
================================================================================
檔案代號:pmck_t
檔案名稱:供應商評核總得分檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:S
多語系檔案:N
============.========================.==========================================
 */
create table pmck_t
(
pmckent       number(5)      ,/* 企業編號 */
pmck001       varchar2(10)      ,/* 評估期別 */
pmck002       varchar2(10)      ,/* 評估品類 */
pmck003       varchar2(10)      ,/* 供應商編號 */
pmck004       number(15,3)      ,/* 系統得分 */
pmck005       number(15,3)      ,/* 調整後得分 */
pmck006       varchar2(10)      ,/* 評核等級 */
pmck007       varchar2(10)      /* 處理方案 */
);
alter table pmck_t add constraint pmck_pk primary key (pmckent,pmck001,pmck002,pmck003) enable validate;

create unique index pmck_pk on pmck_t (pmckent,pmck001,pmck002,pmck003);

grant select on pmck_t to tiptop;
grant update on pmck_t to tiptop;
grant delete on pmck_t to tiptop;
grant insert on pmck_t to tiptop;

exit;
