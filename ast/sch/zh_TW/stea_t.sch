/* 
================================================================================
檔案代號:stea_t
檔案名稱:专柜合同申请主档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table stea_t
(
steaent       number(5)      ,/* 企业编号 */
steasite       varchar2(10)      ,/* 申请组织 */
steaunit       varchar2(10)      ,/* 制定组织 */
steadocdt       date      ,/* 单据日期 */
steaacti       varchar2(1)      ,/* 合同有效 */
steadocno       varchar2(20)      ,/* 单据编号 */
stea000       varchar2(10)      ,/* 作业方式 */
stea001       varchar2(20)      ,/* 合同编号 */
stea002       varchar2(10)      ,/* 版本 */
stea003       varchar2(10)      ,/* 经营方式 */
stea004       varchar2(10)      ,/* 合同类别 */
stea005       varchar2(20)      ,/* 专柜编号 */
stea006       varchar2(10)      ,/* 专柜类型 */
stea007       number(15,3)      ,/* 建筑面积 */
stea008       number(15,3)      ,/* 经营面积 */
stea009       varchar2(40)      ,/* 文件编号 */
stea010       varchar2(10)      ,/* 供应商编号 */
stea011       varchar2(10)      ,/* 主品类 */
stea012       varchar2(10)      ,/* 主品牌 */
stea013       varchar2(10)      ,/* 模板编号 */
stea014       varchar2(10)      ,/* 签订法人 */
stea015       varchar2(20)      ,/* 签订人员 */
stea016       date      ,/* 签订日期 */
stea017       date      ,/* 进场日期 */
stea018       date      ,/* 撤场日期 */
stea019       date      ,/* 生效日期 */
stea020       date      ,/* 失效日期 */
stea021       date      ,/* 作废日期 */
stea022       date      ,/* 甲方日期 */
stea023       date      ,/* 乙方日期 */
stea024       date      ,/* 清退日期 */
stea025       date      ,/* 延期日期 */
stea026       date      ,/* 盖章日期 */
stea027       varchar2(1)      ,/* 文本盖章否 */
stea028       varchar2(1)      ,/* 按天生成销售成本 */
stea029       varchar2(1)      ,/* 收银方式 */
stea030       varchar2(1)      ,/* 定价属性 */
stea031       varchar2(40)      ,/* 专柜ABC */
stea032       varchar2(10)      ,/* 币种 */
stea033       varchar2(10)      ,/* 进项税 */
stea034       varchar2(10)      ,/* 销项税 */
stea035       varchar2(10)      ,/* 付款方式 */
stea036       varchar2(10)      ,/* 结算方式 */
stea037       varchar2(10)      ,/* 结算类别 */
stea038       varchar2(10)      ,/* 结算中心 */
stea039       number(15,3)      ,/* 基本提成率 */
stea040       number(15,3)      ,/* 增值税扣率 */
stea041       varchar2(4000)      ,/* 合同摘要 */
stea042       varchar2(1000)      ,/* 经营范围说明 */
stea043       varchar2(1000)      ,/* 备注 */
stea044       varchar2(10)      ,/* 所属部门 */
stea045       varchar2(10)      ,/* 管理方式 */
stea046       varchar2(10)      ,/* 业态 */
stea047       varchar2(10)      ,/* 楼栋 */
stea048       varchar2(10)      ,/* 楼层 */
stea049       date      ,/* 续签日期 */
steaownid       varchar2(20)      ,/* 资料所有者 */
steaowndp       varchar2(10)      ,/* 资料所有部门 */
steacrtid       varchar2(20)      ,/* 资料录入者 */
steacrtdp       varchar2(10)      ,/* 资料录入部门 */
steacrtdt       timestamp(0)      ,/* 资料创建日 */
steamodid       varchar2(20)      ,/* 资料更改者 */
steamoddt       timestamp(0)      ,/* 最近更改日 */
steastus       varchar2(10)      ,/* 状态码 */
steacnfid       varchar2(20)      ,/* 资料审核者 */
steacnfdt       timestamp(0)      ,/* 数据审核日 */
stea050       varchar2(1)      ,/* 代扣代缴税否 */
stea051       varchar2(10)      ,/* 管理品类 */
stea052       number(20,6)      ,/* 最低折扣率 */
stea053       varchar2(1)      ,/* 促销库区参与保底否 */
stea054       date      ,/* 运行日期 */
stea055       varchar2(1)      ,/* 是否补差 */
stea056       varchar2(1)      ,/* 库区商品化否 */
stea057       varchar2(1)      ,/* 工衣情况 */
stea058       varchar2(1)      ,/* 终止保底计算 */
stea059       varchar2(1)      /* 终止目标销售计算 */
);
alter table stea_t add constraint stea_pk primary key (steaent,steadocno) enable validate;

create unique index stea_pk on stea_t (steaent,steadocno);

grant select on stea_t to tiptop;
grant update on stea_t to tiptop;
grant delete on stea_t to tiptop;
grant insert on stea_t to tiptop;

exit;
