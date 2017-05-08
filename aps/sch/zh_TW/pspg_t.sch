/* 
================================================================================
檔案代號:pspg_t
檔案名稱:SFT現場派工資訊檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:H
多語系檔案:N
============.========================.==========================================
 */
create table pspg_t
(
pspgent       number(5)      ,/* 企業編號 */
pspgsite       varchar2(10)      ,/* 營運據點 */
pspg001       varchar2(10)      ,/* APS版本 */
pspg002       varchar2(20)      ,/* 執行日期時間 */
pspg003       date      ,/* 派工日期 */
pspg004       number(5,0)      ,/* 外包 */
pspg005       number(5,0)      ,/* 資源型態 */
pspg006       varchar2(20)      ,/* 資源編號 */
pspg007       number(10,0)      ,/* 派工順序 */
pspg008       varchar2(40)      ,/* 工單編號 */
pspg009       varchar2(80)      ,/* 途程編號 */
pspg010       varchar2(10)      ,/* 加工序號 */
pspg011       varchar2(10)      ,/* 作業編號 */
pspg012       number(20,6)      ,/* 派工數量 */
pspg013       varchar2(10)      /* 資源群組 */
);
alter table pspg_t add constraint pspg_pk primary key (pspgent,pspgsite,pspg001,pspg002,pspg003,pspg004,pspg005,pspg006,pspg007) enable validate;

create unique index pspg_pk on pspg_t (pspgent,pspgsite,pspg001,pspg002,pspg003,pspg004,pspg005,pspg006,pspg007);

grant select on pspg_t to tiptop;
grant update on pspg_t to tiptop;
grant delete on pspg_t to tiptop;
grant insert on pspg_t to tiptop;

exit;
