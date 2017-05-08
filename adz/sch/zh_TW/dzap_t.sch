/* 
================================================================================
檔案代號:dzap_t
檔案名稱:Patch的merge纪录表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table dzap_t
(
dzap001       varchar2(20)      ,/* 程序编号 */
dzap002       number(5,0)      ,/* no use */
dzap003       varchar2(80)      ,/* patch号码 */
dzap004       number(10)      ,/* 客制建构版次 */
dzap005       number(10)      ,/* 客制规格版次 */
dzap006       number(10)      ,/* 客工艺序版次 */
dzap007       number(10)      ,/* 标准建构版次 */
dzap008       number(10)      ,/* 标准规格版次 */
dzap009       number(10)      ,/* 标准程序版次 */
dzap010       varchar2(1)      ,/* merge否 */
dzap011       varchar2(1)      ,/* no use */
dzap012       varchar2(1)      ,/* no use */
dzapownid       varchar2(20)      ,/* 资料所有者 */
dzapowndp       varchar2(10)      ,/* 资料所有部门 */
dzapcrtid       varchar2(20)      ,/* 资料录入者 */
dzapcrtdp       varchar2(10)      ,/* 资料录入部门 */
dzapcrtdt       timestamp(0)      ,/* 资料创建日 */
dzapmodid       varchar2(20)      ,/* 资料更改者 */
dzapmoddt       timestamp(0)      /* 最近更改日 */
);
alter table dzap_t add constraint dzap_pk primary key (dzap001) enable validate;

create unique index dzap_pk on dzap_t (dzap001);

grant select on dzap_t to tiptop;
grant update on dzap_t to tiptop;
grant delete on dzap_t to tiptop;
grant insert on dzap_t to tiptop;

exit;
