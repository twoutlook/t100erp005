/* 
================================================================================
檔案代號:bcmc_t
檔案名稱:条位数据与库存信息档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table bcmc_t
(
bcmcent       number(5)      ,/* 企业编号 */
bcmcsite       varchar2(10)      ,/* 营运据点 */
bcmc001       varchar2(255)      ,/* 条码编号 */
bcmc002       varchar2(40)      ,/* 料件编号 */
bcmc003       varchar2(256)      ,/* 产品特征 */
bcmc004       varchar2(500)      ,/* 产品特征说明 */
bcmc005       varchar2(10)      ,/* 库位编号 */
bcmc006       varchar2(10)      ,/* 储位编号 */
bcmc007       varchar2(30)      ,/* 批号 */
bcmc008       varchar2(30)      ,/* 库存管理特征 */
bcmc009       varchar2(30)      ,/* 制造批号 */
bcmc010       varchar2(30)      ,/* 制造序号 */
bcmc011       varchar2(10)      ,/* 库存单位 */
bcmc012       number(20,6)      ,/* 条位数量 */
bcmc013       number(20,6)      ,/* 库存数量 */
bcmc014       varchar2(20)      ,/* 来源作业 */
bcmc015       varchar2(20)      ,/* 来源单号 */
bcmc016       number(10,0)      ,/* 来源项次 */
bcmc017       number(10,0)      ,/* 来源项序 */
bcmc018       number(10,0)      ,/* 来源分批序 */
bcmc999       timestamp(5)      ,/* 最后异动时间 */
bcmcstus       varchar2(10)      ,/* 有效否 */
bcmcownid       varchar2(20)      ,/* 资料所有者 */
bcmcowndp       varchar2(10)      ,/* 资料所有部门 */
bcmccrtid       varchar2(20)      ,/* 资料录入者 */
bcmccrtdp       varchar2(10)      ,/* 资料录入部门 */
bcmccrtdt       timestamp(0)      ,/* 资料创建日 */
bcmcmodid       varchar2(20)      ,/* 资料更改者 */
bcmcmoddt       timestamp(0)      ,/* 最近更改日 */
bcmccnfid       varchar2(20)      ,/* 资料审核者 */
bcmccnfdt       timestamp(0)      ,/* 数据审核日 */
bcmcud001       varchar2(40)      ,/* 自定义字段(文本)001 */
bcmcud002       varchar2(40)      ,/* 自定义字段(文本)002 */
bcmcud003       varchar2(40)      ,/* 自定义字段(文本)003 */
bcmcud004       varchar2(40)      ,/* 自定义字段(文本)004 */
bcmcud005       varchar2(40)      ,/* 自定义字段(文本)005 */
bcmcud006       varchar2(40)      ,/* 自定义字段(文本)006 */
bcmcud007       varchar2(40)      ,/* 自定义字段(文本)007 */
bcmcud008       varchar2(40)      ,/* 自定义字段(文本)008 */
bcmcud009       varchar2(40)      ,/* 自定义字段(文本)009 */
bcmcud010       varchar2(40)      ,/* 自定义字段(文本)010 */
bcmcud011       number(20,6)      ,/* 自定义字段(数字)011 */
bcmcud012       number(20,6)      ,/* 自定义字段(数字)012 */
bcmcud013       number(20,6)      ,/* 自定义字段(数字)013 */
bcmcud014       number(20,6)      ,/* 自定义字段(数字)014 */
bcmcud015       number(20,6)      ,/* 自定义字段(数字)015 */
bcmcud016       number(20,6)      ,/* 自定义字段(数字)016 */
bcmcud017       number(20,6)      ,/* 自定义字段(数字)017 */
bcmcud018       number(20,6)      ,/* 自定义字段(数字)018 */
bcmcud019       number(20,6)      ,/* 自定义字段(数字)019 */
bcmcud020       number(20,6)      ,/* 自定义字段(数字)020 */
bcmcud021       timestamp(0)      ,/* 自定义字段(日期时间)021 */
bcmcud022       timestamp(0)      ,/* 自定义字段(日期时间)022 */
bcmcud023       timestamp(0)      ,/* 自定义字段(日期时间)023 */
bcmcud024       timestamp(0)      ,/* 自定义字段(日期时间)024 */
bcmcud025       timestamp(0)      ,/* 自定义字段(日期时间)025 */
bcmcud026       timestamp(0)      ,/* 自定义字段(日期时间)026 */
bcmcud027       timestamp(0)      ,/* 自定义字段(日期时间)027 */
bcmcud028       timestamp(0)      ,/* 自定义字段(日期时间)028 */
bcmcud029       timestamp(0)      ,/* 自定义字段(日期时间)029 */
bcmcud030       timestamp(0)      ,/* 自定义字段(日期时间)030 */
bcmc019       varchar2(30)      ,/* 条码批号 */
bcmc020       varchar2(10)      ,/* 条码类型 */
bcmc021       varchar2(255)      ,/* 品名 */
bcmc022       varchar2(255)      ,/* 规格 */
bcmc023       varchar2(10)      /* 批号管控方式 */
);
alter table bcmc_t add constraint bcmc_pk primary key (bcmcent,bcmcsite,bcmc001,bcmc002,bcmc003,bcmc014,bcmc015,bcmc016,bcmc017,bcmc018) enable validate;

create unique index bcmc_pk on bcmc_t (bcmcent,bcmcsite,bcmc001,bcmc002,bcmc003,bcmc014,bcmc015,bcmc016,bcmc017,bcmc018);

grant select on bcmc_t to tiptop;
grant update on bcmc_t to tiptop;
grant delete on bcmc_t to tiptop;
grant insert on bcmc_t to tiptop;

exit;
