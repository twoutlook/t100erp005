/* 
================================================================================
檔案代號:deca_t
檔案名稱:会员门店单品日结档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:S
多語系檔案:Y
============.========================.==========================================
 */
create table deca_t
(
decaent       number(5)      ,/* 企业编号 */
decasite       varchar2(10)      ,/* 营运据点 */
deca001       varchar2(10)      ,/* 层级类型 */
deca002       date      ,/* 统计日期 */
deca003       number(5,0)      ,/* 会计周 */
deca004       number(5,0)      ,/* 会计期 */
deca005       varchar2(10)      ,/* 库区编号 */
deca006       varchar2(10)      ,/* 库区类型 */
deca007       varchar2(10)      ,/* 存货管理方式 */
deca008       varchar2(10)      ,/* 库区业态 */
deca009       varchar2(40)      ,/* 商品编号 */
deca010       varchar2(40)      ,/* 商品条码 */
deca011       varchar2(255)      ,/* 商品品名 */
deca012       varchar2(255)      ,/* 商品规格 */
deca013       varchar2(20)      ,/* 品牌 */
deca014       varchar2(10)      ,/* 主供应商 */
deca015       varchar2(10)      ,/* 结算方式 */
deca016       varchar2(10)      ,/* 品类编号 */
deca017       varchar2(20)      ,/* 专柜编号 */
deca018       varchar2(10)      ,/* 税种编号 */
deca019       varchar2(10)      ,/* 销售单位 */
deca020       varchar2(30)      ,/* 会员编号 */
deca021       varchar2(10)      ,/* 会员等级 */
deca022       number(20,6)      ,/* 销售数量 */
deca023       number(20,6)      ,/* 销售成本 */
deca024       number(20,6)      ,/* 进价金额 */
deca025       number(20,6)      ,/* 原价金额 */
deca026       number(20,6)      ,/* 税前金额 */
deca027       number(20,6)      ,/* 应收金额 */
deca028       number(20,6)      ,/* 毛利 */
deca029       number(20,6)      ,/* 毛利率 */
deca030       number(22,2)      ,/* 会员积分 */
deca031       number(20,6)      ,/* 客单数 */
deca032       number(20,6)      ,/* 退货金额 */
deca033       number(20,6)      ,/* 退货单据数 */
deca034       number(20,6)      ,/* 客单价 */
deca035       varchar2(30)      ,/* 会员卡号 */
deca036       number(20,6)      ,/* 会员折扣金额 */
deca037       number(20,6)      /* 打折金额 */
);
alter table deca_t add constraint deca_pk primary key (decaent,decasite,deca002,deca005,deca009,deca017,deca018,deca019,deca020,deca035) enable validate;

create unique index deca_pk on deca_t (decaent,decasite,deca002,deca005,deca009,deca017,deca018,deca019,deca020,deca035);

grant select on deca_t to tiptop;
grant update on deca_t to tiptop;
grant delete on deca_t to tiptop;
grant insert on deca_t to tiptop;

exit;
