/* 
================================================================================
檔案代號:stke_t
檔案名稱:招商租賃合約申請單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table stke_t
(
stkeent       number(5)      ,/* 企业编号 */
stkesite       varchar2(10)      ,/* 营运组织 */
stkeunit       varchar2(10)      ,/* 制定组织 */
stkedocdt       date      ,/* 单据日期 */
stkedocno       varchar2(20)      ,/* 单据编号 */
stke000       varchar2(10)      ,/* 作业类型 */
stke001       varchar2(20)      ,/* 合同编号 */
stke002       varchar2(10)      ,/* 版本 */
stke003       varchar2(20)      ,/* 合同项编号 */
stke004       varchar2(10)      ,/* 经营方式 */
stke005       varchar2(10)      ,/* 合同状态 */
stke006       varchar2(20)      ,/* 文件编号 */
stke007       varchar2(10)      ,/* 商户编号 */
stke008       varchar2(20)      ,/* 铺位编号 */
stke009       varchar2(10)      ,/* 租赁类型 */
stke010       varchar2(255)      ,/* 门牌号 */
stke011       date      ,/* 租赁开始日期 */
stke012       date      ,/* 租赁结束日期 */
stke013       number(10,0)      ,/* 免租天数 */
stke014       varchar2(1)      ,/* 首零合并 */
stke015       varchar2(1)      ,/* 尾零合并 */
stke016       date      ,/* 签订日期 */
stke017       varchar2(20)      ,/* 签订人员 */
stke018       varchar2(10)      ,/* 签订部门 */
stke019       varchar2(10)      ,/* 楼栋编号 */
stke020       varchar2(10)      ,/* 楼层编号 */
stke021       varchar2(10)      ,/* 区域编号 */
stke022       varchar2(10)      ,/* 铺位用途 */
stke023       number(20,6)      ,/* 建筑面积 */
stke024       number(20,6)      ,/* 测量面积 */
stke025       number(20,6)      ,/* 经营面积 */
stke026       number(10,0)      ,/* 人数 */
stke027       varchar2(10)      ,/* no use */
stke028       varchar2(10)      ,/* 管理品类 */
stke029       varchar2(10)      ,/* 经营主品牌 */
stke030       varchar2(10)      ,/* 结算组织 */
stke031       varchar2(10)      ,/* 结算方式 */
stke032       varchar2(10)      ,/* 结算类型 */
stke033       varchar2(10)      ,/* 收银方式 */
stke034       varchar2(10)      ,/* 付款条件 */
stke035       varchar2(10)      ,/* 交易条件 */
stke036       varchar2(10)      ,/* 币种 */
stke037       varchar2(10)      ,/* 汇率计算基准 */
stke038       varchar2(10)      ,/* 税种 */
stke039       varchar2(10)      ,/* 发票类型 */
stke040       varchar2(1)      ,/* 含发票否 */
stke041       date      ,/* 运行日期 */
stke042       date      ,/* 进场日期 */
stke043       date      ,/* 延期日期 */
stke044       date      ,/* 原合同开始日期 */
stke045       date      ,/* 清退日期 */
stke046       date      ,/* 作废日期 */
stke047       date      ,/* 盖章日期 */
stke048       varchar2(20)      ,/* 预租协议 */
stke049       varchar2(255)      ,/* 备注 */
stke223       number(20,6)      ,/* 原建筑面积 */
stke224       number(20,6)      ,/* 原测量面积 */
stke225       number(20,6)      ,/* 原经营面积 */
stkestus       varchar2(10)      ,/* 状态码 */
stkeownid       varchar2(20)      ,/* 资料所有者 */
stkeowndp       varchar2(10)      ,/* 资料所有部门 */
stkecrtid       varchar2(20)      ,/* 资料录入者 */
stkecrtdp       varchar2(10)      ,/* 资料录入部门 */
stkecrtdt       timestamp(0)      ,/* 资料创建日 */
stkemodid       varchar2(20)      ,/* 资料更改者 */
stkemoddt       timestamp(0)      ,/* 最近更改日 */
stkecnfid       varchar2(20)      ,/* 资料审核者 */
stkecnfdt       timestamp(0)      ,/* 数据审核日 */
stkeud001       varchar2(40)      ,/* 自定义字段(文本)001 */
stkeud002       varchar2(40)      ,/* 自定义字段(文本)002 */
stkeud003       varchar2(40)      ,/* 自定义字段(文本)003 */
stkeud004       varchar2(40)      ,/* 自定义字段(文本)004 */
stkeud005       varchar2(40)      ,/* 自定义字段(文本)005 */
stkeud006       varchar2(40)      ,/* 自定义字段(文本)006 */
stkeud007       varchar2(40)      ,/* 自定义字段(文本)007 */
stkeud008       varchar2(40)      ,/* 自定义字段(文本)008 */
stkeud009       varchar2(40)      ,/* 自定义字段(文本)009 */
stkeud010       varchar2(40)      ,/* 自定义字段(文本)010 */
stkeud011       number(20,6)      ,/* 自定义字段(数字)011 */
stkeud012       number(20,6)      ,/* 自定义字段(数字)012 */
stkeud013       number(20,6)      ,/* 自定义字段(数字)013 */
stkeud014       number(20,6)      ,/* 自定义字段(数字)014 */
stkeud015       number(20,6)      ,/* 自定义字段(数字)015 */
stkeud016       number(20,6)      ,/* 自定义字段(数字)016 */
stkeud017       number(20,6)      ,/* 自定义字段(数字)017 */
stkeud018       number(20,6)      ,/* 自定义字段(数字)018 */
stkeud019       number(20,6)      ,/* 自定义字段(数字)019 */
stkeud020       number(20,6)      ,/* 自定义字段(数字)020 */
stkeud021       timestamp(0)      ,/* 自定义字段(日期时间)021 */
stkeud022       timestamp(0)      ,/* 自定义字段(日期时间)022 */
stkeud023       timestamp(0)      ,/* 自定义字段(日期时间)023 */
stkeud024       timestamp(0)      ,/* 自定义字段(日期时间)024 */
stkeud025       timestamp(0)      ,/* 自定义字段(日期时间)025 */
stkeud026       timestamp(0)      ,/* 自定义字段(日期时间)026 */
stkeud027       timestamp(0)      ,/* 自定义字段(日期时间)027 */
stkeud028       timestamp(0)      ,/* 自定义字段(日期时间)028 */
stkeud029       timestamp(0)      ,/* 自定义字段(日期时间)029 */
stkeud030       timestamp(0)      ,/* 自定义字段(日期时间)030 */
stke050       date      ,/* 初审异动日期 */
stke051       varchar2(20)      ,/* 初审异动人员 */
stke052       date      ,/* 终审异动日期 */
stke053       varchar2(20)      ,/* 终审异动人员 */
stke200       varchar2(20)      /* 变更申请单号 */
);
alter table stke_t add constraint stke_pk primary key (stkeent,stkedocno,stke001) enable validate;

create unique index stke_pk on stke_t (stkeent,stkedocno,stke001);

grant select on stke_t to tiptop;
grant update on stke_t to tiptop;
grant delete on stke_t to tiptop;
grant insert on stke_t to tiptop;

exit;
