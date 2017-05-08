/* 
================================================================================
檔案代號:faah_t
檔案名稱:固定资产基础数据档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table faah_t
(
faahent       number(5)      ,/* 企业编号 */
faah000       varchar2(10)      ,/* 生成批号 */
faah001       varchar2(10)      ,/* 卡片编号 */
faah002       number(10)      ,/* 型态 */
faah003       varchar2(20)      ,/* 财产编号 */
faah004       varchar2(20)      ,/* 附号 */
faah005       number(10)      ,/* 资产性质 */
faah006       varchar2(10)      ,/* 资产主要类型 */
faah007       varchar2(10)      ,/* 资产次要类型 */
faah008       varchar2(10)      ,/* 资产组 */
faah009       varchar2(10)      ,/* 供应供应商 */
faah010       varchar2(10)      ,/* 制造供应商 */
faah011       varchar2(40)      ,/* 产地 */
faah012       varchar2(255)      ,/* 名称 */
faah013       varchar2(255)      ,/* 规格型号 */
faah014       date      ,/* 取得日期 */
faah015       number(10)      ,/* 资产状态 */
faah016       number(10)      ,/* 取得方式 */
faah017       varchar2(10)      ,/* 单位 */
faah018       number(20,6)      ,/* 数量 */
faah019       number(20,6)      ,/* 在外数量 */
faah020       varchar2(10)      ,/* 币种 */
faah021       number(20,6)      ,/* 原币单价 */
faah022       number(20,6)      ,/* 原币金额 */
faah023       number(20,6)      ,/* 本币单价 */
faah024       number(20,6)      ,/* 本币金额 */
faah025       varchar2(20)      ,/* 保管人员 */
faah026       varchar2(10)      ,/* 保管部门 */
faah027       varchar2(10)      ,/* 存放位置 */
faah028       varchar2(10)      ,/* 存放组织 */
faah029       varchar2(20)      ,/* 负责人员 */
faah030       varchar2(10)      ,/* 管理组织 */
faah031       varchar2(10)      ,/* 核算组织 */
faah032       varchar2(10)      ,/* 归属法人 */
faah033       varchar2(1)      ,/* 直接资本化 */
faah034       number(10)      ,/* 保税 */
faah035       number(10)      ,/* 保险 */
faah036       number(10)      ,/* 免税 */
faah037       number(10)      ,/* 抵押 */
faah038       varchar2(20)      ,/* 采购单号 */
faah039       varchar2(20)      ,/* 收货单号 */
faah040       varchar2(20)      ,/* 账款单号 */
faah041       varchar2(10)      ,/* 来源营运中心 */
faah042       number(10)      ,/* 资产属性 */
faah043       number(15,3)      ,/* 预计总工作量 */
faah044       number(15,3)      ,/* 已使用工作量 */
faah045       number(10,0)      ,/* 账款编号项次 */
faahownid       varchar2(20)      ,/* 资料所有者 */
faahowndp       varchar2(10)      ,/* 资料所有部门 */
faahcrtid       varchar2(20)      ,/* 资料录入者 */
faahcrtdp       varchar2(10)      ,/* 资料录入部门 */
faahcrtdt       timestamp(0)      ,/* 资料创建日 */
faahmodid       varchar2(20)      ,/* 资料更改者 */
faahmoddt       timestamp(0)      ,/* 最近更改日 */
faahstus       varchar2(10)      ,/* 状态码 */
faah046       varchar2(255)      ,/* 备注 */
faahud001       varchar2(40)      ,/* 自定义字段(文本)001 */
faahud002       varchar2(40)      ,/* 自定义字段(文本)002 */
faahud003       varchar2(40)      ,/* 自定义字段(文本)003 */
faahud004       varchar2(40)      ,/* 自定义字段(文本)004 */
faahud005       varchar2(40)      ,/* 自定义字段(文本)005 */
faahud006       varchar2(40)      ,/* 自定义字段(文本)006 */
faahud007       varchar2(40)      ,/* 自定义字段(文本)007 */
faahud008       varchar2(40)      ,/* 自定义字段(文本)008 */
faahud009       varchar2(40)      ,/* 自定义字段(文本)009 */
faahud010       varchar2(40)      ,/* 自定义字段(文本)010 */
faahud011       number(20,6)      ,/* 自定义字段(数字)011 */
faahud012       number(20,6)      ,/* 自定义字段(数字)012 */
faahud013       number(20,6)      ,/* 自定义字段(数字)013 */
faahud014       number(20,6)      ,/* 自定义字段(数字)014 */
faahud015       number(20,6)      ,/* 自定义字段(数字)015 */
faahud016       number(20,6)      ,/* 自定义字段(数字)016 */
faahud017       number(20,6)      ,/* 自定义字段(数字)017 */
faahud018       number(20,6)      ,/* 自定义字段(数字)018 */
faahud019       number(20,6)      ,/* 自定义字段(数字)019 */
faahud020       number(20,6)      ,/* 自定义字段(数字)020 */
faahud021       timestamp(0)      ,/* 自定义字段(日期时间)021 */
faahud022       timestamp(0)      ,/* 自定义字段(日期时间)022 */
faahud023       timestamp(0)      ,/* 自定义字段(日期时间)023 */
faahud024       timestamp(0)      ,/* 自定义字段(日期时间)024 */
faahud025       timestamp(0)      ,/* 自定义字段(日期时间)025 */
faahud026       timestamp(0)      ,/* 自定义字段(日期时间)026 */
faahud027       timestamp(0)      ,/* 自定义字段(日期时间)027 */
faahud028       timestamp(0)      ,/* 自定义字段(日期时间)028 */
faahud029       timestamp(0)      ,/* 自定义字段(日期时间)029 */
faahud030       timestamp(0)      ,/* 自定义字段(日期时间)030 */
faah047       varchar2(1)      ,/* 保税机器截取否 */
faah048       number(10)      ,/* 投资抵减状态 */
faah049       number(10)      ,/* 投资抵减合并码 */
faah050       number(20,6)      ,/* 抵减率 */
faah051       varchar2(40)      ,/* 投资抵减用途 */
faah052       number(20,6)      ,/* 抵减金额 */
faah053       number(20,6)      ,/* 已抵减金额 */
faah054       varchar2(1)      ,/* 投资抵减否 */
faah055       number(10,0)      ,/* 投资抵减年限 */
faah056       number(10)      ,/* 免税状态 */
faah057       varchar2(20)      ,/* 杂发单号 */
faah058       number(10,0)      /* 杂发单号项次 */
);
alter table faah_t add constraint faah_pk primary key (faahent,faah000,faah001,faah003,faah004) enable validate;

create unique index faah_pk on faah_t (faahent,faah000,faah001,faah003,faah004);

grant select on faah_t to tiptop;
grant update on faah_t to tiptop;
grant delete on faah_t to tiptop;
grant insert on faah_t to tiptop;

exit;
