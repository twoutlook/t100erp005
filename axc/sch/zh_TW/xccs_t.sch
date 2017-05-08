/* 
================================================================================
檔案代號:xccs_t
檔案名稱:料件明细结存盘-提速用
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table xccs_t
(
xccsent       number(5)      ,/* 企业编号 */
xccssite       varchar2(10)      ,/* site组织 */
xccscomp       varchar2(10)      ,/* 法人组织 */
xccsld       varchar2(5)      ,/* 账套 */
xccs001       varchar2(1)      ,/* 账套本位币顺序 */
xccs002       varchar2(30)      ,/* 成本域 */
xccs003       varchar2(10)      ,/* 成本计算类型 */
xccs006       varchar2(20)      ,/* 参考单号 */
xccs007       number(10,0)      ,/* 项次 */
xccs008       number(5,0)      ,/* 项序 */
xccs009       number(5,0)      ,/* 出入库码 */
xccs010       varchar2(40)      ,/* 料号 */
xccs011       varchar2(256)      ,/* 特性 */
xccs012       varchar2(10)      ,/* 单据类型 */
xccs013       date      ,/* 单据日期 */
xccs014       varchar2(8)      ,/* 时间 */
xccs015       varchar2(10)      ,/* 仓库编号 */
xccs016       varchar2(10)      ,/* 储位编号 */
xccs017       varchar2(30)      ,/* 批号 */
xccs020       varchar2(10)      ,/* 异动类型 */
xccs021       varchar2(10)      ,/* 原因码 */
xccs022       varchar2(10)      ,/* 交易对象 */
xccs023       varchar2(10)      ,/* 客群 */
xccs024       varchar2(10)      ,/* 区域 */
xccs025       varchar2(10)      ,/* 成本中心 */
xccs026       varchar2(10)      ,/* 经营类别 */
xccs027       varchar2(10)      ,/* 渠道 */
xccs028       varchar2(10)      ,/* 品类 */
xccs029       varchar2(10)      ,/* 品牌 */
xccs030       varchar2(20)      ,/* 项目号 */
xccs031       varchar2(30)      ,/* WBS */
xccs032       varchar2(24)      ,/* 存货科目 */
xccs033       varchar2(24)      ,/* 费用成本科目 */
xccs034       varchar2(24)      ,/* 收入科目 */
xccs040       varchar2(10)      ,/* 交易币种 */
xccs041       varchar2(10)      ,/* 本位币种 */
xccs042       number(20,10)      ,/* 汇率 */
xccs043       varchar2(10)      ,/* 交易单位 */
xccs044       varchar2(10)      ,/* 成本单位 */
xccs045       number(20,6)      ,/* 换算率 */
xccs046       number(20,6)      ,/* 交易数量 */
xccs047       varchar2(20)      ,/* 工单号码 */
xccs048       varchar2(10)      ,/* 重复性生产-计划编号 */
xccs049       varchar2(40)      ,/* 重复性生产-生产料号 */
xccs050       varchar2(30)      ,/* 重复性生产-生产料号BOM特性 */
xccs051       varchar2(256)      ,/* 重复性生产-生产料号产品特征 */
xccs055       varchar2(10)      ,/* xccc类型 */
xccs201       number(20,6)      ,/* 本期异动数量 */
xccs202       number(20,6)      ,/* 本期异动金额 */
xccs202a       number(20,6)      ,/* 本期异动金额-材料 */
xccs202b       number(20,6)      ,/* 本期异动金额-人工 */
xccs202c       number(20,6)      ,/* 本期异动金额-加工费 */
xccs202d       number(20,6)      ,/* 本期异动金额-制费一 */
xccs202e       number(20,6)      ,/* 本期异动金额-制费二 */
xccs202f       number(20,6)      ,/* 本期异动金额-制费三 */
xccs202g       number(20,6)      ,/* 本期异动金额-制费四 */
xccs202h       number(20,6)      ,/* 本期异动金额-制费五 */
xccs282       number(20,6)      ,/* 本期异动单价 */
xccs282a       number(20,6)      ,/* 本期异动单价-材料 */
xccs282b       number(20,6)      ,/* 本期异动单价-人工 */
xccs282c       number(20,6)      ,/* 本期异动单价-加工 */
xccs282d       number(20,6)      ,/* 本期异动单价-制费一 */
xccs282e       number(20,6)      ,/* 本期异动单价-制费二 */
xccs282f       number(20,6)      ,/* 本期异动单价-制费三 */
xccs282g       number(20,6)      ,/* 本期异动单价-制费四 */
xccs282h       number(20,6)      ,/* 本期异动单价-制费五 */
xccs301       number(20,6)      ,/* 已耗数量 */
xccs302       number(20,6)      ,/* 已耗金额 */
xccs302a       number(20,6)      ,/* 已耗金额-材料 */
xccs302b       number(20,6)      ,/* 已耗金额-人工 */
xccs302c       number(20,6)      ,/* 已耗金额-加工费 */
xccs302d       number(20,6)      ,/* 已耗金额-制费一 */
xccs302e       number(20,6)      ,/* 已耗金额-制费二 */
xccs302f       number(20,6)      ,/* 已耗金额-制费三 */
xccs302g       number(20,6)      ,/* 已耗金额-制费四 */
xccs302h       number(20,6)      ,/* 已耗金额-制费五 */
xccs901       number(20,6)      ,/* 结存数量 */
xccs902       number(20,6)      ,/* 结存金额 */
xccs902a       number(20,6)      ,/* 结存金额-材料 */
xccs902b       number(20,6)      ,/* 结存金额-人工 */
xccs902c       number(20,6)      ,/* 结存金额-加工费 */
xccs902d       number(20,6)      ,/* 结存金额-制费一 */
xccs902e       number(20,6)      ,/* 结存金额-制费二 */
xccs902f       number(20,6)      ,/* 结存金额-制费三 */
xccs902g       number(20,6)      ,/* 结存金额-制费四 */
xccs902h       number(20,6)      ,/* 结存金额-制费五 */
xccs980       number(20,6)      ,/* 结存单位成本 */
xccs980a       number(20,6)      ,/* 结存单位成本-材料 */
xccs980b       number(20,6)      ,/* 结存单位成本-人工 */
xccs980c       number(20,6)      ,/* 结存单位成本-加工费 */
xccs980d       number(20,6)      ,/* 结存单位成本-制费一 */
xccs980e       number(20,6)      ,/* 结存单位成本-制费二 */
xccs980f       number(20,6)      ,/* 结存单位成本-制费三 */
xccs980g       number(20,6)      ,/* 结存单位成本-制费四 */
xccs980h       number(20,6)      ,/* 结存单位成本-制费五 */
xccs903       number(20,6)      ,/* 结存调整金额 */
xccs903a       number(20,6)      ,/* 结存调整金额-材料 */
xccs903b       number(20,6)      ,/* 结存调整金额-人工 */
xccs903c       number(20,6)      ,/* 结存调整金额-加工费 */
xccs903d       number(20,6)      ,/* 结存调整金额-制费一 */
xccs903e       number(20,6)      ,/* 结存调整金额-制费二 */
xccs903f       number(20,6)      ,/* 结存调整金额-制费三 */
xccs903g       number(20,6)      ,/* 结存调整金额-制费四 */
xccs903h       number(20,6)      ,/* 结存调整金额-制费五 */
xccsownid       varchar2(20)      ,/* 资料所有者 */
xccsowndp       varchar2(10)      ,/* 资料所有部门 */
xccscrtid       varchar2(20)      ,/* 资料录入者 */
xccscrtdp       varchar2(10)      ,/* 资料录入部门 */
xccscrtdt       timestamp(0)      ,/* 资料创建日 */
xccsmodid       varchar2(20)      ,/* 资料更改者 */
xccsmoddt       timestamp(0)      ,/* 最近更改日 */
xccsstus       varchar2(10)      ,/* 状态码 */
xccsud001       varchar2(40)      ,/* 自定义字段(文本)001 */
xccsud002       varchar2(40)      ,/* 自定义字段(文本)002 */
xccsud003       varchar2(40)      ,/* 自定义字段(文本)003 */
xccsud004       varchar2(40)      ,/* 自定义字段(文本)004 */
xccsud005       varchar2(40)      ,/* 自定义字段(文本)005 */
xccsud006       varchar2(40)      ,/* 自定义字段(文本)006 */
xccsud007       varchar2(40)      ,/* 自定义字段(文本)007 */
xccsud008       varchar2(40)      ,/* 自定义字段(文本)008 */
xccsud009       varchar2(40)      ,/* 自定义字段(文本)009 */
xccsud010       varchar2(40)      ,/* 自定义字段(文本)010 */
xccsud011       number(20,6)      ,/* 自定义字段(数字)011 */
xccsud012       number(20,6)      ,/* 自定义字段(数字)012 */
xccsud013       number(20,6)      ,/* 自定义字段(数字)013 */
xccsud014       number(20,6)      ,/* 自定义字段(数字)014 */
xccsud015       number(20,6)      ,/* 自定义字段(数字)015 */
xccsud016       number(20,6)      ,/* 自定义字段(数字)016 */
xccsud017       number(20,6)      ,/* 自定义字段(数字)017 */
xccsud018       number(20,6)      ,/* 自定义字段(数字)018 */
xccsud019       number(20,6)      ,/* 自定义字段(数字)019 */
xccsud020       number(20,6)      ,/* 自定义字段(数字)020 */
xccsud021       timestamp(0)      ,/* 自定义字段(日期时间)021 */
xccsud022       timestamp(0)      ,/* 自定义字段(日期时间)022 */
xccsud023       timestamp(0)      ,/* 自定义字段(日期时间)023 */
xccsud024       timestamp(0)      ,/* 自定义字段(日期时间)024 */
xccsud025       timestamp(0)      ,/* 自定义字段(日期时间)025 */
xccsud026       timestamp(0)      ,/* 自定义字段(日期时间)026 */
xccsud027       timestamp(0)      ,/* 自定义字段(日期时间)027 */
xccsud028       timestamp(0)      ,/* 自定义字段(日期时间)028 */
xccsud029       timestamp(0)      ,/* 自定义字段(日期时间)029 */
xccsud030       timestamp(0)      ,/* 自定义字段(日期时间)030 */
xccs401       number(20,6)      ,/* 前笔异动差异数量 */
xccs402       number(20,6)      ,/* 前笔异动差异金额 */
xccs402a       number(20,6)      ,/* 前笔异动差异金额-材料 */
xccs402b       number(20,6)      ,/* 前笔异动差异金额-人工 */
xccs402c       number(20,6)      ,/* 前笔异动差异金额-加工费 */
xccs402d       number(20,6)      ,/* 前笔异动差异金额-制费一 */
xccs402e       number(20,6)      ,/* 前笔异动差异金额-制费二 */
xccs402f       number(20,6)      ,/* 前笔异动差异金额-制费三 */
xccs402g       number(20,6)      ,/* 前笔异动差异金额-制费四 */
xccs402h       number(20,6)      /* 前笔异动差异金额-制费五 */
);
alter table xccs_t add constraint xccs_pk primary key (xccsent,xccsld,xccs001,xccs002,xccs003,xccs006,xccs007,xccs008,xccs009) enable validate;

create unique index xccs_pk on xccs_t (xccsent,xccsld,xccs001,xccs002,xccs003,xccs006,xccs007,xccs008,xccs009);

grant select on xccs_t to tiptop;
grant update on xccs_t to tiptop;
grant delete on xccs_t to tiptop;
grant insert on xccs_t to tiptop;

exit;
