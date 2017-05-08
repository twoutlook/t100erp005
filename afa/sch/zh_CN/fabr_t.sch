/* 
================================================================================
檔案代號:fabr_t
檔案名稱:固定资产盘点数据档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table fabr_t
(
fabrent       number(5)      ,/* 企业编号 */
fabrcomp       varchar2(10)      ,/* 法人 */
fabr001       varchar2(10)      ,/* 资产中心 */
fabr002       varchar2(20)      ,/* 财务人员 */
fabr003       varchar2(10)      ,/* 盘点编号 */
fabr004       number(10,0)      ,/* 盘点序号 */
fabr005       varchar2(20)      ,/* 财产编号 */
fabr006       varchar2(20)      ,/* 附号 */
fabr007       varchar2(10)      ,/* 卡片编号 */
fabr008       number(10)      ,/* 资产性质 */
fabr009       number(10)      ,/* 资产状态 */
fabr010       varchar2(10)      ,/* 资产组 */
fabr011       varchar2(10)      ,/* 单位 */
fabr012       number(20,6)      ,/* 数量 */
fabr013       number(20,6)      ,/* 在外数量 */
fabr014       varchar2(10)      ,/* 保管部门 */
fabr015       varchar2(20)      ,/* 保管人员 */
fabr016       varchar2(10)      ,/* 存放位置 */
fabr017       varchar2(20)      ,/* 负责人员 */
fabr018       varchar2(10)      ,/* 管理组织 */
fabr019       varchar2(10)      ,/* 所有组织 */
fabr020       varchar2(10)      ,/* 核算组织 */
fabr021       varchar2(10)      ,/* 归属法人 */
fabr022       varchar2(10)      ,/* 单位 */
fabr023       number(20,6)      ,/* 数量 */
fabr024       varchar2(10)      ,/* 实际保管部门 */
fabr025       varchar2(20)      ,/* 实际保管人员 */
fabr026       varchar2(10)      ,/* 实际存放位置 */
fabr027       varchar2(10)      ,/* 实际管理组织 */
fabr028       varchar2(10)      ,/* 实际所有组织 */
fabr029       varchar2(10)      ,/* 实际核算组织 */
fabr030       varchar2(10)      ,/* 实际归属法人 */
fabr031       date      ,/* 盘点日期 */
fabr032       varchar2(20)      ,/* 盘点人员 */
fabr033       date      ,/* 生成日期 */
fabr034       varchar2(20)      ,/* 生成人员 */
fabr035       varchar2(1)      ,/* 过账码 */
fabrownid       varchar2(20)      ,/* 资料所有者 */
fabrowndp       varchar2(10)      ,/* 资料所有部门 */
fabrcrtid       varchar2(20)      ,/* 资料录入者 */
fabrcrtdp       varchar2(10)      ,/* 资料录入部门 */
fabrcrtdt       timestamp(0)      ,/* 资料创建日 */
fabrmodid       varchar2(20)      ,/* 资料更改者 */
fabrmoddt       timestamp(0)      ,/* 最近更改日 */
fabrcnfid       varchar2(20)      ,/* 资料审核者 */
fabrcnfdt       timestamp(0)      ,/* 数据审核日 */
fabrpstid       varchar2(20)      ,/* 资料过账者 */
fabrpstdt       timestamp(0)      ,/* 资料过账日 */
fabrstus       varchar2(10)      ,/* 状态码 */
fabr036       varchar2(20)      ,/* 实际负责人员 */
fabr037       varchar2(10)      ,/* 资产主要类型 */
fabr038       varchar2(10)      ,/* 资产次要类型 */
fabr039       varchar2(10)      ,/* 币种 */
fabr040       number(20,6)      ,/* 原币单价 */
fabr041       number(20,6)      ,/* 原币金额 */
fabr042       number(20,6)      ,/* 本币单价 */
fabr043       number(20,6)      ,/* 本币金额 */
fabr044       varchar2(100)      ,/* 列账/列管 */
fabr045       varchar2(255)      ,/* 名称 */
fabr046       varchar2(255)      ,/* 规格型号 */
fabr047       varchar2(10)      /* 原因码 */
);
alter table fabr_t add constraint fabr_pk primary key (fabrent,fabr003,fabr004) enable validate;

create unique index fabr_pk on fabr_t (fabrent,fabr003,fabr004);

grant select on fabr_t to tiptop;
grant update on fabr_t to tiptop;
grant delete on fabr_t to tiptop;
grant insert on fabr_t to tiptop;

exit;
