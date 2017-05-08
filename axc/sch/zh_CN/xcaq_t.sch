/* 
================================================================================
檔案代號:xcaq_t
檔案名稱:成本差异分摊对象科目设置档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table xcaq_t
(
xcaqent       number(5)      ,/* 企业编号 */
xcaqld       varchar2(5)      ,/* 账套编号 */
xcaqseq       number(10,0)      ,/* 项次 */
xcaq001       varchar2(80)      ,/* 差异科目分类 */
xcaq002       varchar2(80)      ,/* 分摊公式类型 */
xcaq003       varchar2(24)      ,/* 分摊对象科目编码 */
xcaq004       varchar2(80)      ,/* 摘要 */
xcaq005       varchar2(1)      ,/* 借/贷 */
xcaq006       number(20,6)      ,/* 分摊率% */
xcaq007       varchar2(10)      ,/* 营运据点 */
xcaq008       varchar2(20)      ,/* 人员 */
xcaq009       varchar2(10)      ,/* 部门 */
xcaq010       varchar2(10)      ,/* 交易客商 */
xcaq011       varchar2(10)      ,/* 账款客户 */
xcaq012       varchar2(10)      ,/* 客群 */
xcaq013       varchar2(10)      ,/* 区域 */
xcaq014       varchar2(10)      ,/* 利润/成本中心 */
xcaq015       varchar2(10)      ,/* 经营方式 */
xcaq016       varchar2(10)      ,/* 渠道 */
xcaq017       varchar2(10)      ,/* 产品类别 */
xcaq018       varchar2(10)      ,/* 品牌 */
xcaq019       varchar2(20)      ,/* 项目编号 */
xcaq020       varchar2(30)      ,/* WBS */
xcaq021       varchar2(10)      ,/* 自由核算项一 */
xcaq022       varchar2(10)      ,/* 自由核算项二 */
xcaq023       varchar2(10)      ,/* 自由核算项三 */
xcaq024       varchar2(10)      ,/* 自由核算项四 */
xcaq025       varchar2(10)      ,/* 自由核算项五 */
xcaq026       varchar2(10)      ,/* 自由核算项六 */
xcaq027       varchar2(10)      ,/* 自由核算项七 */
xcaq028       varchar2(10)      ,/* 自由核算项八 */
xcaq029       varchar2(10)      ,/* 自由核算项九 */
xcaq030       varchar2(10)      /* 自由核算项十 */
);
alter table xcaq_t add constraint xcaq_pk primary key (xcaqent,xcaqld,xcaqseq,xcaq001,xcaq002,xcaq003) enable validate;

create unique index xcaq_pk on xcaq_t (xcaqent,xcaqld,xcaqseq,xcaq001,xcaq002,xcaq003);

grant select on xcaq_t to tiptop;
grant update on xcaq_t to tiptop;
grant delete on xcaq_t to tiptop;
grant insert on xcaq_t to tiptop;

exit;
