/* 
================================================================================
檔案代號:xcaz_t
檔案名稱:成本类型计算参数设置档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:P
多語系檔案:N
============.========================.==========================================
 */
create table xcaz_t
(
xcazent       number(5)      ,/* 企业编号 */
xcazld       varchar2(5)      ,/* 账套 */
xcaz001       varchar2(10)      ,/* 成本计算类型 */
xcaz002       varchar2(1)      ,/* 计算方法 */
xcaz003       varchar2(1)      ,/* 计算时点 */
xcaz004       varchar2(1)      ,/* 成本要素 */
xcaz005       varchar2(1)      ,/* 成本域类型 */
xcaz006       varchar2(1)      ,/* 计价方式 */
xcaz007       number(5,0)      ,/* 最近计算成本年度 */
xcaz008       number(5,0)      ,/* 最近计算成本期别 */
xcaz009       varchar2(10)      ,/* 委外加工次要素类别 */
xcazownid       varchar2(20)      ,/* 资料所有者 */
xcazowndp       varchar2(10)      ,/* 资料所有部门 */
xcazcrtid       varchar2(20)      ,/* 资料录入者 */
xcazcrtdp       varchar2(10)      ,/* 资料录入部门 */
xcazcrtdt       timestamp(0)      ,/* 资料创建日 */
xcazmodid       varchar2(20)      ,/* 资料更改者 */
xcazmoddt       timestamp(0)      ,/* 最近更改日 */
xcazstus       varchar2(10)      ,/* 状态码 */
xcaz010       varchar2(1)      ,/* 成本含税否 */
xcaz011       varchar2(10)      /* 标准成本分类 */
);
alter table xcaz_t add constraint xcaz_pk primary key (xcazent,xcazld,xcaz001) enable validate;

create unique index xcaz_pk on xcaz_t (xcazent,xcazld,xcaz001);

grant select on xcaz_t to tiptop;
grant update on xcaz_t to tiptop;
grant delete on xcaz_t to tiptop;
grant insert on xcaz_t to tiptop;

exit;
