/* 
================================================================================
檔案代號:pspb_t
檔案名稱:訂單展階配置關係檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:H
多語系檔案:N
============.========================.==========================================
 */
create table pspb_t
(
pspbent       number(5)      ,/* 企業編號 */
pspbsite       varchar2(10)      ,/* 營運據點 */
pspb001       varchar2(10)      ,/* APS版本 */
pspb002       varchar2(20)      ,/* 執行日期時間 */
pspb003       varchar2(40)      ,/* 供給單號 */
pspb004       varchar2(40)      ,/* 被供給單號 */
pspb005       number(5,0)      ,/* 訂單需求 */
pspb006       number(5,0)      ,/* 鎖定供需 */
pspb007       number(5,0)      ,/* 採購件 */
pspb008       varchar2(40)      ,/* 最上層需求單據 */
pspb009       number(5,0)      ,/* 低階碼 */
pspb010       number(10,0)      /* 流水編號 */
);
alter table pspb_t add constraint pspb_pk primary key (pspbent,pspbsite,pspb001,pspb002,pspb010) enable validate;

create unique index pspb_pk on pspb_t (pspbent,pspbsite,pspb001,pspb002,pspb010);

grant select on pspb_t to tiptop;
grant update on pspb_t to tiptop;
grant delete on pspb_t to tiptop;
grant insert on pspb_t to tiptop;

exit;
