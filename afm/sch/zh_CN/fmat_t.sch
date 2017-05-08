/* 
================================================================================
檔案代號:fmat_t
檔案名稱:NO USE
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table fmat_t
(
fmatent       number(5)      ,/* no use */
fmat001       varchar2(20)      ,/* no use */
fmat002       number(10,0)      ,/* no use */
fmat003       varchar2(10)      ,/* no use */
fmat004       varchar2(10)      ,/* no use */
fmat005       varchar2(10)      ,/* no use */
fmat006       number(10,0)      ,/* no use */
fmat007       varchar2(1)      ,/* no use */
fmat008       varchar2(10)      ,/* no use */
fmat009       number(20,6)      ,/* no use */
fmat010       number(20,10)      ,/* no use */
fmat011       number(20,6)      ,/* no use */
fmat012       varchar2(24)      ,/* no use */
fmat013       number(20,10)      ,/* no use */
fmat014       number(20,6)      ,/* no use */
fmat015       number(20,10)      ,/* no use */
fmat016       number(20,6)      ,/* no use */
fmat017       number(20,10)      ,/* no use */
fmat018       number(20,6)      ,/* no use */
fmat019       number(20,6)      ,/* no use */
fmat020       number(20,10)      ,/* no use */
fmat021       number(20,6)      ,/* no use */
fmat022       number(20,6)      ,/* no use */
fmat023       number(20,10)      ,/* no use */
fmat024       number(20,6)      ,/* no use */
fmat025       number(20,6)      ,/* no use */
fmat026       varchar2(10)      ,/* no use */
fmat027       varchar2(10)      ,/* no use */
fmat028       varchar2(10)      ,/* no use */
fmat029       varchar2(10)      ,/* no use */
fmat030       varchar2(10)      ,/* no use */
fmat031       varchar2(10)      ,/* no use */
fmat032       varchar2(10)      ,/* no use */
fmat033       varchar2(10)      ,/* no use */
fmat034       varchar2(20)      ,/* no use */
fmat035       varchar2(10)      ,/* no use */
fmat036       varchar2(20)      ,/* no use */
fmat037       varchar2(30)      ,/* no use */
fmat038       varchar2(10)      ,/* no use */
fmat039       varchar2(10)      ,/* no use */
fmat040       varchar2(10)      ,/* no use */
fmat041       varchar2(30)      ,/* no use */
fmat042       varchar2(30)      ,/* no use */
fmat043       varchar2(30)      ,/* no use */
fmat044       varchar2(30)      ,/* no use */
fmat045       varchar2(30)      ,/* no use */
fmat046       varchar2(30)      ,/* no use */
fmat047       varchar2(30)      ,/* no use */
fmat048       varchar2(30)      ,/* no use */
fmat049       varchar2(30)      ,/* no use */
fmat050       varchar2(30)      /* no use */
);
alter table fmat_t add constraint fmat_pk primary key (fmatent,fmat001,fmat002) enable validate;

create unique index fmat_pk on fmat_t (fmatent,fmat001,fmat002);

grant select on fmat_t to tiptop;
grant update on fmat_t to tiptop;
grant delete on fmat_t to tiptop;
grant insert on fmat_t to tiptop;

exit;
