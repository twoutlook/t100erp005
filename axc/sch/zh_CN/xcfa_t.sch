/* 
================================================================================
檔案代號:xcfa_t
檔案名稱:LCM计算基础设置档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table xcfa_t
(
xcfaent       number(5)      ,/* 企业编号 */
xcfacomp       varchar2(10)      ,/* 法人组织 */
xcfald       varchar2(5)      ,/* 账套 */
xcfa001       number(5,0)      ,/* 年度 */
xcfa002       number(5,0)      ,/* 期别 */
xcfa003       varchar2(1)      ,/* 货龄计算基准 */
xcfa004       varchar2(1)      ,/* 呆滞计算基准 */
xcfa005       varchar2(1)      ,/* 净变现取成本价否 */
xcfa006       varchar2(1)      ,/* 净变现料件分类来源 */
xcfa007       varchar2(1)      ,/* 净变现原料评价 */
xcfa008       varchar2(1)      ,/* 净变现单价 */
xcfa009       varchar2(1)      ,/* 净变现人工维护市价来源 */
xcfa010       date      ,/* No Use */
xcfa011       varchar2(1)      ,/* 原料逆推成品料号否 */
xcfa012       varchar2(1)      ,/* 逆推成品取价方式 */
xcfa013       varchar2(10)      ,/* 逆推成品排序 */
xcfa014       varchar2(10)      /* 货龄计算顺序 */
);
alter table xcfa_t add constraint xcfa_pk primary key (xcfaent,xcfald,xcfa001,xcfa002) enable validate;

create unique index xcfa_pk on xcfa_t (xcfaent,xcfald,xcfa001,xcfa002);

grant select on xcfa_t to tiptop;
grant update on xcfa_t to tiptop;
grant delete on xcfa_t to tiptop;
grant insert on xcfa_t to tiptop;

exit;
