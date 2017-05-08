/* 
================================================================================
檔案代號:fmbf_t
檔案名稱:NO USE
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table fmbf_t
(
fmbfent       number(5)      ,/* no use */
fmbf001       varchar2(20)      ,/* no use */
fmbf002       number(10,0)      ,/* no use */
fmbf003       varchar2(10)      ,/* no use */
fmbf004       varchar2(10)      ,/* no use */
fmbf005       varchar2(10)      ,/* no use */
fmbf006       number(10,0)      ,/* no use */
fmbf007       varchar2(20)      ,/* no use */
fmbf008       number(10,0)      ,/* no use */
fmbf009       varchar2(10)      ,/* no use */
fmbf010       number(20,6)      ,/* no use */
fmbf011       number(20,10)      ,/* no use */
fmbf012       number(20,6)      ,/* no use */
fmbf013       varchar2(24)      ,/* no use */
fmbf014       number(20,10)      ,/* no use */
fmbf015       number(20,6)      ,/* no use */
fmbf016       number(20,10)      ,/* no use */
fmbf017       number(20,6)      ,/* no use */
fmbf018       number(20,10)      ,/* no use */
fmbf019       number(20,6)      ,/* no use */
fmbf020       number(20,6)      ,/* no use */
fmbf021       number(20,10)      ,/* no use */
fmbf022       number(20,6)      ,/* no use */
fmbf023       number(20,6)      ,/* no use */
fmbf024       number(20,10)      ,/* no use */
fmbf025       number(20,6)      ,/* no use */
fmbf026       number(20,6)      ,/* no use */
fmbf027       varchar2(10)      ,/* no use */
fmbf028       varchar2(10)      ,/* no use */
fmbf029       varchar2(10)      ,/* no use */
fmbf030       varchar2(10)      ,/* no use */
fmbf031       varchar2(10)      ,/* no use */
fmbf032       varchar2(10)      ,/* no use */
fmbf033       varchar2(10)      ,/* no use */
fmbf034       varchar2(10)      ,/* no use */
fmbf035       varchar2(20)      ,/* no use */
fmbf036       varchar2(10)      ,/* no use */
fmbf037       varchar2(20)      ,/* no use */
fmbf038       varchar2(30)      ,/* no use */
fmbf039       varchar2(10)      ,/* no use */
fmbf040       varchar2(10)      ,/* no use */
fmbf041       varchar2(10)      ,/* no use */
fmbf042       varchar2(30)      ,/* no use */
fmbf043       varchar2(30)      ,/* no use */
fmbf044       varchar2(30)      ,/* no use */
fmbf045       varchar2(30)      ,/* no use */
fmbf046       varchar2(30)      ,/* no use */
fmbf047       varchar2(30)      ,/* no use */
fmbf048       varchar2(30)      ,/* no use */
fmbf049       varchar2(30)      ,/* no use */
fmbf050       varchar2(30)      ,/* no use */
fmbf051       varchar2(30)      /* no use */
);
alter table fmbf_t add constraint fmbf_pk primary key (fmbfent,fmbf001,fmbf002) enable validate;

create unique index fmbf_pk on fmbf_t (fmbfent,fmbf001,fmbf002);

grant select on fmbf_t to tiptop;
grant update on fmbf_t to tiptop;
grant delete on fmbf_t to tiptop;
grant insert on fmbf_t to tiptop;

exit;
