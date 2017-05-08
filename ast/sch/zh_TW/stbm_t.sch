/* 
================================================================================
檔案代號:stbm_t
檔案名稱:DM促銷單明細表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table stbm_t
(
stbment       number(5)      ,/* 企業編號 */
stbmunit       varchar2(10)      ,/* 制定组织 */
stbmsite       varchar2(10)      ,/* 营运组织 */
stbmdocno       varchar2(20)      ,/* 單號编号 */
stbmseq       number(10,0)      ,/* 项次 */
stbm001       varchar2(40)      ,/* 商品编号 */
stbm002       varchar2(40)      ,/* 商品条码 */
stbm003       varchar2(256)      ,/* 商品特征 */
stbm004       varchar2(10)      ,/* 进价计价单位 */
stbm005       varchar2(10)      ,/* 进项税别 */
stbm006       date      ,/* 采购起始日期 */
stbm007       date      ,/* 采购截止日期 */
stbm008       number(20,6)      ,/* 促销进价 */
stbm009       varchar2(10)      ,/* 售价计价单位 */
stbm010       varchar2(10)      ,/* 销项税别 */
stbm011       date      ,/* 销售起始日期 */
stbm012       date      ,/* 销售截止日期 */
stbm013       number(20,6)      ,/* 促销售价 */
stbm014       number(20,6)      ,/* 会员价1 */
stbm015       number(20,6)      ,/* 会员价2 */
stbm016       number(20,6)      ,/* 会员价3 */
stbm017       number(20,6)      ,/* 结算扣率 */
stbm018       varchar2(10)      ,/* 货架类型 */
stbm019       varchar2(10)      ,/* 货架编号 */
stbm020       varchar2(80)      ,/* 位置说明 */
stbm021       varchar2(10)      ,/* 陈列费用编号 */
stbm022       number(20,6)      ,/* 费用金额 */
stbm023       date      ,/* 费用计算日期 */
stbm024       varchar2(10)      ,/* 费用计算状态 */
stbm025       varchar2(10)      ,/* 补差类型 */
stbm026       varchar2(10)      ,/* 补差方式 */
stbm027       number(20,6)      ,/* 差价/基准价/毛利率 */
stbm028       date      ,/* 补差计算日期 */
stbm029       varchar2(10)      ,/* 补差计算状态 */
stbm030       varchar2(10)      ,/* 供應商編號 */
stbm031       number(20,6)      ,/* 費用承擔比例% */
stbm032       number(20,6)      ,/* 補差承擔比例% */
stbm033       varchar2(20)      /* 促銷協議單號 */
);
alter table stbm_t add constraint stbm_pk primary key (stbment,stbmdocno,stbmseq) enable validate;

create unique index stbm_pk on stbm_t (stbment,stbmdocno,stbmseq);

grant select on stbm_t to tiptop;
grant update on stbm_t to tiptop;
grant delete on stbm_t to tiptop;
grant insert on stbm_t to tiptop;

exit;
