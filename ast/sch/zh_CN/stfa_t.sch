/* 
================================================================================
檔案代號:stfa_t
檔案名稱:专柜合同主档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table stfa_t
(
stfaent       number(5)      ,/* 企业编号 */
stfasite       varchar2(10)      ,/* 营运据点 */
stfaunit       varchar2(10)      ,/* 制定组织 */
stfaacti       varchar2(1)      ,/* 合同有效 */
stfa001       varchar2(20)      ,/* 合同编号 */
stfa002       varchar2(10)      ,/* 版本 */
stfa003       varchar2(10)      ,/* 经营方式 */
stfa004       varchar2(10)      ,/* 合同状态 */
stfa005       varchar2(20)      ,/* 专柜编号 */
stfa006       varchar2(10)      ,/* 专柜类型 */
stfa007       number(15,3)      ,/* 建筑面积 */
stfa008       number(15,3)      ,/* 经营面积 */
stfa009       varchar2(40)      ,/* 文件编号 */
stfa010       varchar2(10)      ,/* 供应商编号 */
stfa011       varchar2(10)      ,/* 主品类 */
stfa012       varchar2(10)      ,/* 主品牌 */
stfa013       varchar2(10)      ,/* 模板编号 */
stfa014       varchar2(10)      ,/* 签订法人 */
stfa015       varchar2(20)      ,/* 签订人员 */
stfa016       date      ,/* 签订日期 */
stfa017       date      ,/* 进场日期 */
stfa018       date      ,/* 撤场日期 */
stfa019       date      ,/* 生效日期 */
stfa020       date      ,/* 失效日期 */
stfa021       date      ,/* 作废日期 */
stfa022       date      ,/* 甲方日期 */
stfa023       date      ,/* 乙方日期 */
stfa024       date      ,/* 清退日期 */
stfa025       date      ,/* 延期日期 */
stfa026       date      ,/* 盖章日期 */
stfa027       varchar2(1)      ,/* 文本盖章否 */
stfa028       varchar2(1)      ,/* 按天生成销售成本 */
stfa029       varchar2(1)      ,/* 收银方式 */
stfa030       varchar2(1)      ,/* 定价属性 */
stfa031       varchar2(40)      ,/* 专柜ABC */
stfa032       varchar2(10)      ,/* 币种 */
stfa033       varchar2(10)      ,/* 进项税 */
stfa034       varchar2(10)      ,/* 销项税 */
stfa035       varchar2(10)      ,/* 收付款方式 */
stfa036       varchar2(10)      ,/* 结算方式 */
stfa037       varchar2(10)      ,/* 结算类别 */
stfa038       varchar2(10)      ,/* 结算中心 */
stfa039       number(15,3)      ,/* 基本提成率 */
stfa040       number(15,3)      ,/* 增值税扣率 */
stfa041       varchar2(4000)      ,/* 合同摘要 */
stfa042       varchar2(1000)      ,/* 经营范围说明 */
stfa043       varchar2(1000)      ,/* 备注 */
stfa044       varchar2(10)      ,/* 所属部门 */
stfa045       varchar2(10)      ,/* 管理方式 */
stfa046       varchar2(10)      ,/* 业态 */
stfa047       varchar2(10)      ,/* 楼栋 */
stfa048       varchar2(10)      ,/* 楼层 */
stfa049       date      ,/* 续签日期 */
stfaownid       varchar2(20)      ,/* 资料所有者 */
stfaowndp       varchar2(10)      ,/* 资料所有部门 */
stfacrtid       varchar2(20)      ,/* 资料录入者 */
stfacrtdp       varchar2(10)      ,/* 资料录入部门 */
stfacrtdt       timestamp(0)      ,/* 资料创建日 */
stfamodid       varchar2(20)      ,/* 资料更改者 */
stfamoddt       timestamp(0)      ,/* 最近更改日 */
stfastus       varchar2(10)      ,/* 状态码 */
stfacnfid       varchar2(20)      ,/* 资料审核者 */
stfacnfdt       timestamp(0)      ,/* 数据审核日 */
stfa050       varchar2(1)      ,/* 代扣代缴税否 */
stfa051       varchar2(10)      ,/* 管理品类 */
stfa052       number(20,6)      ,/* 最低折扣率 */
stfa053       varchar2(1)      ,/* 促销库区参与保底否 */
stfa054       varchar2(1)      ,/* 是否补差 */
stfa055       varchar2(1)      ,/* 库区商品化否 */
stfa056       varchar2(1)      ,/* 工衣情况 */
stfa057       varchar2(1)      ,/* 终止保底计算 */
stfa058       varchar2(1)      /* 终止目标销售计算 */
);
alter table stfa_t add constraint stfa_pk primary key (stfaent,stfa001) enable validate;

create unique index stfa_pk on stfa_t (stfaent,stfa001);

grant select on stfa_t to tiptop;
grant update on stfa_t to tiptop;
grant delete on stfa_t to tiptop;
grant insert on stfa_t to tiptop;

exit;
