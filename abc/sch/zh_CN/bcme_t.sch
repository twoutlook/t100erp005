/* 
================================================================================
檔案代號:bcme_t
檔案名稱:来源单据明细档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table bcme_t
(
bcmeent       number(5)      ,/* 企业编号 */
bcmesite       varchar2(10)      ,/* 营运据点 */
bcme001       varchar2(20)      ,/* 来源作业 */
bcme002       varchar2(20)      ,/* 来源单号 */
bcme003       varchar2(10)      ,/* 单据类型 */
bcme004       date      ,/* 单据日期 */
bcme005       number(10,0)      ,/* 单据项次 */
bcme006       number(10,0)      ,/* 单据项序 */
bcme007       number(10,0)      ,/* 单据分批序 */
bcme008       varchar2(10)      ,/* 对象编号 */
bcme009       varchar2(80)      ,/* 对象名称 */
bcme010       varchar2(40)      ,/* 料件编号 */
bcme011       varchar2(256)      ,/* 产品特征 */
bcme012       varchar2(500)      ,/* 产品特征说明 */
bcme013       varchar2(10)      ,/* 库位 */
bcme014       varchar2(10)      ,/* 储位 */
bcme015       varchar2(30)      ,/* 批号 */
bcme016       varchar2(30)      ,/* 库存管理特征 */
bcme017       number(20,6)      ,/* 单据数量 */
bcme018       number(20,6)      ,/* 出入数量 */
bcme019       date      ,/* 出入日期1 */
bcme020       date      ,/* 出入日期2 */
bcme021       varchar2(1)      ,/* 数据处理否 */
bcme022       varchar2(1)      ,/* 结案否 */
bcme023       varchar2(20)      ,/* 上阶单据编号 */
bcme024       number(10,0)      ,/* 上阶单据项次 */
bcme025       number(10,0)      ,/* 上阶单据项序 */
bcme026       number(10,0)      ,/* 上阶单据分批序 */
bcme999       timestamp(5)      ,/* 最后异动时间 */
bcmestus       varchar2(10)      ,/* 有效否 */
bcmeownid       varchar2(20)      ,/* 资料所有者 */
bcmeowndp       varchar2(10)      ,/* 资料所有部门 */
bcmecrtid       varchar2(20)      ,/* 资料录入者 */
bcmecrtdp       varchar2(10)      ,/* 资料录入部门 */
bcmecrtdt       timestamp(0)      ,/* 资料创建日 */
bcmemodid       varchar2(20)      ,/* 资料更改者 */
bcmemoddt       timestamp(0)      ,/* 最近更改日 */
bcmecnfid       varchar2(20)      ,/* 资料审核者 */
bcmecnfdt       timestamp(0)      ,/* 数据审核日 */
bcmeud001       varchar2(40)      ,/* 自定义字段(文本)001 */
bcmeud002       varchar2(40)      ,/* 自定义字段(文本)002 */
bcmeud003       varchar2(40)      ,/* 自定义字段(文本)003 */
bcmeud004       varchar2(40)      ,/* 自定义字段(文本)004 */
bcmeud005       varchar2(40)      ,/* 自定义字段(文本)005 */
bcmeud006       varchar2(40)      ,/* 自定义字段(文本)006 */
bcmeud007       varchar2(40)      ,/* 自定义字段(文本)007 */
bcmeud008       varchar2(40)      ,/* 自定义字段(文本)008 */
bcmeud009       varchar2(40)      ,/* 自定义字段(文本)009 */
bcmeud010       varchar2(40)      ,/* 自定义字段(文本)010 */
bcmeud011       number(20,6)      ,/* 自定义字段(数字)011 */
bcmeud012       number(20,6)      ,/* 自定义字段(数字)012 */
bcmeud013       number(20,6)      ,/* 自定义字段(数字)013 */
bcmeud014       number(20,6)      ,/* 自定义字段(数字)014 */
bcmeud015       number(20,6)      ,/* 自定义字段(数字)015 */
bcmeud016       number(20,6)      ,/* 自定义字段(数字)016 */
bcmeud017       number(20,6)      ,/* 自定义字段(数字)017 */
bcmeud018       number(20,6)      ,/* 自定义字段(数字)018 */
bcmeud019       number(20,6)      ,/* 自定义字段(数字)019 */
bcmeud020       number(20,6)      ,/* 自定义字段(数字)020 */
bcmeud021       timestamp(0)      ,/* 自定义字段(日期时间)021 */
bcmeud022       timestamp(0)      ,/* 自定义字段(日期时间)022 */
bcmeud023       timestamp(0)      ,/* 自定义字段(日期时间)023 */
bcmeud024       timestamp(0)      ,/* 自定义字段(日期时间)024 */
bcmeud025       timestamp(0)      ,/* 自定义字段(日期时间)025 */
bcmeud026       timestamp(0)      ,/* 自定义字段(日期时间)026 */
bcmeud027       timestamp(0)      ,/* 自定义字段(日期时间)027 */
bcmeud028       timestamp(0)      ,/* 自定义字段(日期时间)028 */
bcmeud029       timestamp(0)      ,/* 自定义字段(日期时间)029 */
bcmeud030       timestamp(0)      ,/* 自定义字段(日期时间)030 */
bcme027       varchar2(40)      ,/* 生产料号 */
bcme028       number(20,6)      ,/* 生产数量 */
bcme029       varchar2(255)      ,/* 品名规格 */
bcme030       varchar2(10)      ,/* 生产单位 */
bcme031       varchar2(10)      ,/* 上阶单据单位 */
bcme032       varchar2(10)      ,/* 参考单位 */
bcme033       number(20,6)      ,/* 参考数量 */
bcme034       number(20,6)      ,/* 上阶单据数量 */
bcme035       varchar2(10)      ,/* 原单单位 */
bcme036       number(20,6)      ,/* 允许误差率 */
bcme127       varchar2(256)      ,/* 生产料号产品特征 */
bcme128       number(20,6)      ,/* 生产出入数量 */
bcme037       number(10,0)      ,/* RunCard */
bcme038       number(20,6)      ,/* QPA分子 */
bcme039       number(20,6)      ,/* QPA分母 */
bcme040       varchar2(10)      ,/* 主营组织 */
bcme041       varchar2(10)      ,/* 拨出仓库 */
bcme042       varchar2(10)      ,/* 拨出储位 */
bcme043       varchar2(255)      ,/* 品名 */
bcme044       varchar2(255)      ,/* 规格 */
bcme045       varchar2(10)      ,/* 批号管控方式 */
bcme046       number(20,6)      ,/* 单位转换率分母 */
bcme047       number(20,6)      ,/* 单位转换率分子 */
bcme048       varchar2(10)      /* 库存单位 */
);
alter table bcme_t add constraint bcme_pk primary key (bcmeent,bcmesite,bcme001,bcme002,bcme005,bcme006,bcme007) enable validate;

create unique index bcme_pk on bcme_t (bcmeent,bcmesite,bcme001,bcme002,bcme005,bcme006,bcme007);

grant select on bcme_t to tiptop;
grant update on bcme_t to tiptop;
grant delete on bcme_t to tiptop;
grant insert on bcme_t to tiptop;

exit;
