/* 
================================================================================
檔案代號:pspq_t
檔案名稱:Frim_OP_Time(產能鎖定資料)
檔案目的: 
上游檔案:
下游檔案:
檔案類型:H
多語系檔案:N
============.========================.==========================================
 */
create table pspq_t
(
pspqent       number(5)      ,/* 企業編號 */
pspqsite       varchar2(10)      ,/* 營運據點 */
pspq001       varchar2(10)      ,/* APS版本 */
pspq002       varchar2(20)      ,/* 執行日期時間 */
pspq003       varchar2(80)      ,/* mfg_order_id */
pspq004       varchar2(80)      ,/* route_id */
pspq005       varchar2(80)      ,/* sequ_num */
pspq006       varchar2(80)      ,/* operation_id */
pspq007       number(10,0)      ,/* equip_type */
pspq008       varchar2(80)      ,/* equip_id */
pspq009       number(10,0)      ,/* firm_code */
pspq010       timestamp(0)      ,/* start_time */
pspq011       timestamp(0)      ,/* end_time */
pspq012       number(10,0)      ,/* is_scheduled */
pspq013       number(10,0)      /* is_parallel */
);
alter table pspq_t add constraint pspq_pk primary key (pspqent,pspqsite,pspq001,pspq002,pspq003,pspq004,pspq005,pspq006,pspq007,pspq008) enable validate;

create unique index pspq_pk on pspq_t (pspqent,pspqsite,pspq001,pspq002,pspq003,pspq004,pspq005,pspq006,pspq007,pspq008);

grant select on pspq_t to tiptop;
grant update on pspq_t to tiptop;
grant delete on pspq_t to tiptop;
grant insert on pspq_t to tiptop;

exit;
