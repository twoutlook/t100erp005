/* 
================================================================================
檔案代號:pjba_t
檔案名稱:项目数据单头档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table pjba_t
(
pjbaent       number(5)      ,/* 企业编号 */
pjba000       varchar2(10)      ,/* 项目类型 */
pjba001       varchar2(20)      ,/* 项目编号 */
pjba002       varchar2(1)      ,/* 范本 */
pjba003       varchar2(20)      ,/* 范本项目编号 */
pjba004       varchar2(10)      ,/* 项目计算币种 */
pjba005       date      ,/* 立案日期 */
pjba006       varchar2(255)      ,/* 备注 */
pjba007       varchar2(10)      ,/* WBS计划起始/截止日遇非工作日的处理方式 */
pjba008       varchar2(5)      ,/* 参考行事历参照表号 */
pjbaownid       varchar2(20)      ,/* 资料所有者 */
pjbaowndp       varchar2(10)      ,/* 资料所有部门 */
pjbacrtid       varchar2(20)      ,/* 资料录入者 */
pjbacrtdp       varchar2(10)      ,/* 资料录入部门 */
pjbacrtdt       timestamp(0)      ,/* 资料创建日 */
pjbamodid       varchar2(20)      ,/* 资料更改者 */
pjbamoddt       timestamp(0)      ,/* 最近更改日 */
pjbacnfid       varchar2(20)      ,/* 资料审核者 */
pjbacnfdt       timestamp(0)      ,/* 数据审核日 */
pjbastus       varchar2(10)      ,/* 状态码 */
pjbaud001       varchar2(40)      ,/* 客户编号 */
pjbaud002       varchar2(40)      ,/* 自定义字段(文本)002 */
pjbaud003       varchar2(40)      ,/* 自定义字段(文本)003 */
pjbaud004       varchar2(40)      ,/* 自定义字段(文本)004 */
pjbaud005       varchar2(40)      ,/* 自定义字段(文本)005 */
pjbaud006       varchar2(40)      ,/* 自定义字段(文本)006 */
pjbaud007       varchar2(40)      ,/* 自定义字段(文本)007 */
pjbaud008       varchar2(40)      ,/* 自定义字段(文本)008 */
pjbaud009       varchar2(40)      ,/* 自定义字段(文本)009 */
pjbaud010       varchar2(40)      ,/* 自定义字段(文本)010 */
pjbaud011       number(20,6)      ,/* 自定义字段(数字)011 */
pjbaud012       number(20,6)      ,/* 自定义字段(数字)012 */
pjbaud013       number(20,6)      ,/* 自定义字段(数字)013 */
pjbaud014       number(20,6)      ,/* 自定义字段(数字)014 */
pjbaud015       number(20,6)      ,/* 自定义字段(数字)015 */
pjbaud016       number(20,6)      ,/* 自定义字段(数字)016 */
pjbaud017       number(20,6)      ,/* 自定义字段(数字)017 */
pjbaud018       number(20,6)      ,/* 自定义字段(数字)018 */
pjbaud019       number(20,6)      ,/* 自定义字段(数字)019 */
pjbaud020       number(20,6)      ,/* 自定义字段(数字)020 */
pjbaud021       timestamp(0)      ,/* 自定义字段(日期时间)021 */
pjbaud022       timestamp(0)      ,/* 自定义字段(日期时间)022 */
pjbaud023       timestamp(0)      ,/* 自定义字段(日期时间)023 */
pjbaud024       timestamp(0)      ,/* 自定义字段(日期时间)024 */
pjbaud025       timestamp(0)      ,/* 自定义字段(日期时间)025 */
pjbaud026       timestamp(0)      ,/* 自定义字段(日期时间)026 */
pjbaud027       timestamp(0)      ,/* 自定义字段(日期时间)027 */
pjbaud028       timestamp(0)      ,/* 自定义字段(日期时间)028 */
pjbaud029       timestamp(0)      ,/* 自定义字段(日期时间)029 */
pjbaud030       timestamp(0)      ,/* 自定义字段(日期时间)030 */
pjba009       number(10,0)      ,/* 版次 */
pjba010       varchar2(10)      ,/* 项目进度 */
pjba011       varchar2(1)      ,/* 项目结案 */
pjba012       varchar2(20)      ,/* 结案人员 */
pjba013       timestamp(0)      ,/* 结案日期 */
pjba014       varchar2(10)      ,/* 结案理由码 */
pjba015       varchar2(10)      ,/* 认列方式 */
pjba016       number(20,6)      ,/* 本币预算金额(税前) */
pjba017       number(20,6)      ,/* 本币合同金额(税前) */
pjba018       number(20,6)      ,/* 本币预算合同金额(含税) */
pjba019       number(20,6)      ,/* 本币合同金额(含税) */
pjba020       number(10,0)      ,/* 报价版本 */
pjba021       varchar2(10)      ,/* 结案阶段设置 */
pjba022       varchar2(10)      ,/* 结案状态 */
pjba023       date      ,/* 财会结案日 */
pjba024       date      ,/* 保固结案日 */
pjba025       varchar2(20)      ,/* 最终业主 */
pjba026       varchar2(10)      ,/* 人工分摊选项 */
pjba027       varchar2(1)      ,/* 请款审核单是否签回 */
pjba028       date      ,/* 签回日 */
pjba029       varchar2(1)      ,/* 保固切结书是否签回 */
pjba030       date      ,/* 签回日 */
pjba031       date      ,/* 保固起始日期 */
pjba032       date      ,/* 保固截止日期 */
pjba033       number(20,6)      ,/* 估列保固成本 */
pjba034       varchar2(255)      ,/* 备注 */
pjba035       varchar2(1)      ,/* 检核否 */
pjba036       number(20,6)      ,/* 估列材料 */
pjba037       number(20,6)      ,/* 估列工包 */
pjba038       number(20,6)      ,/* 估列费用 */
pjba039       number(20,6)      ,/* 估列总计 */
pjba040       varchar2(1)      ,/* 检验否 */
pjba041       number(20,6)      ,/* 估列材料 */
pjba042       number(20,6)      ,/* 估列工包 */
pjba043       number(20,6)      ,/* 估列费用 */
pjba044       number(20,6)      ,/* 估列总计 */
pjba045       varchar2(1)      ,/* 检验否 */
pjba046       number(20,6)      ,/* 估列材料 */
pjba047       number(20,6)      ,/* 估列工包 */
pjba048       number(20,6)      ,/* 估列费用 */
pjba049       number(20,6)      ,/* 估列总计 */
pjba050       varchar2(1)      ,/* 检验否 */
pjba051       number(20,6)      ,/* 项目预估成本-材料 */
pjba052       number(20,6)      ,/* 项目预估成本-人工 */
pjba053       number(20,6)      ,/* 项目预估成本-加工费 */
pjba054       number(20,6)      ,/* 项目预估成本-制费一 */
pjba055       number(20,6)      ,/* 项目预估成本-制费二 */
pjba056       number(20,6)      ,/* 项目预估成本-制费三 */
pjba057       number(20,6)      ,/* 项目预估成本-制费四 */
pjba058       number(20,6)      /* 项目预估成本-制费五 */
);
alter table pjba_t add constraint pjba_pk primary key (pjbaent,pjba001) enable validate;

create unique index pjba_pk on pjba_t (pjbaent,pjba001);

grant select on pjba_t to tiptop;
grant update on pjba_t to tiptop;
grant delete on pjba_t to tiptop;
grant insert on pjba_t to tiptop;

exit;
