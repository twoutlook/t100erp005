/* 
================================================================================
檔案代號:bgbc_t
檔案名稱:预算统计档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:S
多語系檔案:N
============.========================.==========================================
 */
create table bgbc_t
(
bgbcent       number(5)      ,/* 企业编号 */
bgbc001       varchar2(10)      ,/* 预算编号 */
bgbc002       varchar2(10)      ,/* 版本 */
bgbc003       varchar2(10)      ,/* 预算组织 */
bgbc004       varchar2(1000)      ,/* 组合KEY */
bgbc005       number(5,0)      ,/* 周期 */
bgbc006       number(5,0)      ,/* 期别 */
bgbc007       varchar2(24)      ,/* 预算细项 */
bgbc008       number(20,6)      ,/* 借方金额 */
bgbc009       number(20,6)      ,/* 贷方金额 */
bgbc010       varchar2(10)      ,/* 计量单位 */
bgbc011       number(20,6)      ,/* 数量 */
bgbc012       number(20,6)      ,/* 单价 */
bgbc013       varchar2(10)      ,/* 交易币种 */
bgbc014       number(20,10)      ,/* 汇率 */
bgbc015       number(5,2)      ,/* 税率 */
bgbc016       number(20,6)      ,/* 原币金额 */
bgbc017       varchar2(10)      ,/* 部门 */
bgbc018       varchar2(10)      ,/* 成本利润中心 */
bgbc019       varchar2(10)      ,/* 区域 */
bgbc020       varchar2(10)      ,/* 交易客商 */
bgbc021       varchar2(10)      ,/* 收款客商 */
bgbc022       varchar2(10)      ,/* 客群 */
bgbc023       varchar2(10)      ,/* 产品类别 */
bgbc024       varchar2(20)      ,/* 人员 */
bgbc025       varchar2(20)      ,/* 项目编号 */
bgbc026       varchar2(30)      ,/* WBS */
bgbc027       varchar2(10)      ,/* 经营方式 */
bgbc028       varchar2(10)      ,/* 渠道 */
bgbc029       varchar2(30)      ,/* 自由核算项一 */
bgbc030       varchar2(30)      ,/* 自由核算项二 */
bgbc031       varchar2(30)      ,/* 自由核算项三 */
bgbc032       varchar2(30)      ,/* 自由核算项四 */
bgbc033       varchar2(30)      ,/* 自由核算项五 */
bgbc034       varchar2(30)      ,/* 自由核算项六 */
bgbc035       varchar2(30)      ,/* 自由核算项七 */
bgbc036       varchar2(30)      ,/* 自由核算项八 */
bgbc037       varchar2(30)      ,/* 自由核算项九 */
bgbc038       varchar2(30)      ,/* 自由核算项十 */
bgbc039       varchar2(10)      ,/* 现金变动码 */
bgbc040       varchar2(10)      ,/* 品牌 */
bgbc041       varchar2(20)      ,/* 来源作业 */
bgbc042       varchar2(20)      ,/* 来源单据 */
bgbc043       varchar2(1)      /* 生成滚动预算否 */
);
alter table bgbc_t add constraint bgbc_pk primary key (bgbcent,bgbc001,bgbc002,bgbc003,bgbc004,bgbc006,bgbc007) enable validate;

create unique index bgbc_pk on bgbc_t (bgbcent,bgbc001,bgbc002,bgbc003,bgbc004,bgbc006,bgbc007);

grant select on bgbc_t to tiptop;
grant update on bgbc_t to tiptop;
grant delete on bgbc_t to tiptop;
grant insert on bgbc_t to tiptop;

exit;
