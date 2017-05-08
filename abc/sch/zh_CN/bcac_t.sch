/* 
================================================================================
檔案代號:bcac_t
檔案名稱:条码信息变更档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table bcac_t
(
bcacent       number(5)      ,/* 企业编号 */
bcacsite       varchar2(10)      ,/* 营运据点 */
bcacdocno       varchar2(20)      ,/* 调整单号 */
bcacdocdt       date      ,/* 调整日期 */
bcac000       number(5,0)      ,/* 单据性质 */
bcac001       varchar2(255)      ,/* 条码编号 */
bcac002       varchar2(40)      ,/* 料件编号 */
bcac003       varchar2(20)      ,/* 来源作业 */
bcac004       varchar2(20)      ,/* 来源单号 */
bcac005       number(10,0)      ,/* 来源项次 */
bcac006       number(10,0)      ,/* 来源项序 */
bcac007       number(10,0)      ,/* 来源分批序 */
bcac008       varchar2(256)      ,/* 产品特征 */
bcac009       number(20,6)      ,/* 条位数量 */
bcac011       varchar2(255)      ,/* 原条码编号 */
bcac012       varchar2(10)      ,/* 料件单位 */
bcac013       varchar2(20)      ,/* 调整人员 */
bcac014       varchar2(10)      ,/* 调整部门 */
bcacstus       varchar2(10)      ,/* 状态码 */
bcaccomp       varchar2(10)      ,/* 所属法人 */
bcacownid       varchar2(20)      ,/* 资料所有者 */
bcacowndp       varchar2(10)      ,/* 资料所有部门 */
bcaccrtid       varchar2(20)      ,/* 资料录入者 */
bcaccrtdp       varchar2(10)      ,/* 资料录入部门 */
bcaccrtdt       timestamp(0)      ,/* 资料创建日 */
bcacmodid       varchar2(20)      ,/* 资料更改者 */
bcacmoddt       timestamp(0)      ,/* 最近更改日 */
bcaccnfid       varchar2(20)      ,/* 资料审核者 */
bcaccnfdt       timestamp(0)      ,/* 数据审核日 */
bcacud001       varchar2(40)      ,/* 自定义字段(文本)001 */
bcacud002       varchar2(40)      ,/* 自定义字段(文本)002 */
bcacud003       varchar2(40)      ,/* 自定义字段(文本)003 */
bcacud004       varchar2(40)      ,/* 自定义字段(文本)004 */
bcacud005       varchar2(40)      ,/* 自定义字段(文本)005 */
bcacud006       varchar2(40)      ,/* 自定义字段(文本)006 */
bcacud007       varchar2(40)      ,/* 自定义字段(文本)007 */
bcacud008       varchar2(40)      ,/* 自定义字段(文本)008 */
bcacud009       varchar2(40)      ,/* 自定义字段(文本)009 */
bcacud010       varchar2(40)      ,/* 自定义字段(文本)010 */
bcacud011       number(20,6)      ,/* 自定义字段(数字)011 */
bcacud012       number(20,6)      ,/* 自定义字段(数字)012 */
bcacud013       number(20,6)      ,/* 自定义字段(数字)013 */
bcacud014       number(20,6)      ,/* 自定义字段(数字)014 */
bcacud015       number(20,6)      ,/* 自定义字段(数字)015 */
bcacud016       number(20,6)      ,/* 自定义字段(数字)016 */
bcacud017       number(20,6)      ,/* 自定义字段(数字)017 */
bcacud018       number(20,6)      ,/* 自定义字段(数字)018 */
bcacud019       number(20,6)      ,/* 自定义字段(数字)019 */
bcacud020       number(20,6)      ,/* 自定义字段(数字)020 */
bcacud021       timestamp(0)      ,/* 自定义字段(日期时间)021 */
bcacud022       timestamp(0)      ,/* 自定义字段(日期时间)022 */
bcacud023       timestamp(0)      ,/* 自定义字段(日期时间)023 */
bcacud024       timestamp(0)      ,/* 自定义字段(日期时间)024 */
bcacud025       timestamp(0)      ,/* 自定义字段(日期时间)025 */
bcacud026       timestamp(0)      ,/* 自定义字段(日期时间)026 */
bcacud027       timestamp(0)      ,/* 自定义字段(日期时间)027 */
bcacud028       timestamp(0)      ,/* 自定义字段(日期时间)028 */
bcacud029       timestamp(0)      ,/* 自定义字段(日期时间)029 */
bcacud030       timestamp(0)      ,/* 自定义字段(日期时间)030 */
bcac015       varchar2(40)      ,/* 组合/拆分类型 */
bcac016       varchar2(40)      ,/* 库位 */
bcac017       varchar2(40)      ,/* 储位 */
bcac018       varchar2(40)      ,/* 批号 */
bcac019       varchar2(10)      ,/* 条码类型 */
bcac020       number(20,6)      /* 箱装数 */
);
alter table bcac_t add constraint bcac_pk primary key (bcacent,bcacdocno) enable validate;

create unique index bcac_pk on bcac_t (bcacent,bcacdocno);

grant select on bcac_t to tiptop;
grant update on bcac_t to tiptop;
grant delete on bcac_t to tiptop;
grant insert on bcac_t to tiptop;

exit;
