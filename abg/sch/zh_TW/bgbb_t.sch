/* 
================================================================================
檔案代號:bgbb_t
檔案名稱:预算凭证单身档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table bgbb_t
(
bgbbent       number(5)      ,/* 企业编号 */
bgbb001       varchar2(10)      ,/* 预算编号 */
bgbbdocno       varchar2(20)      ,/* 单据编号 */
bgbbseq       number(10,0)      ,/* 项次 */
bgbb002       varchar2(24)      ,/* 预算细项 */
bgbb003       number(20,6)      ,/* 借方金额 */
bgbb004       number(20,6)      ,/* 贷方金额 */
bgbb005       varchar2(10)      ,/* 计量单位 */
bgbb006       number(20,6)      ,/* 数量 */
bgbb007       number(20,6)      ,/* 单价 */
bgbb008       varchar2(10)      ,/* 交易币别 */
bgbb009       number(20,10)      ,/* 汇率 */
bgbb010       number(20,6)      ,/* 原币金额 */
bgbb011       varchar2(10)      ,/* 部门 */
bgbb012       varchar2(10)      ,/* 利润成本中心 */
bgbb013       varchar2(10)      ,/* 区域 */
bgbb014       varchar2(10)      ,/* 收付款客商 */
bgbb015       varchar2(10)      ,/* 账款客商 */
bgbb016       varchar2(10)      ,/* 客群 */
bgbb017       varchar2(10)      ,/* 产品类别 */
bgbb018       varchar2(20)      ,/* 人员 */
bgbb019       varchar2(20)      ,/* 专案编号 */
bgbb020       varchar2(30)      ,/* WBS */
bgbb021       varchar2(10)      ,/* 经营方式 */
bgbb022       varchar2(10)      ,/* 通路 */
bgbb023       varchar2(10)      ,/* 品牌 */
bgbb024       varchar2(10)      ,/* 现金码 */
bgbb025       varchar2(30)      ,/* 自由核算项一 */
bgbb026       varchar2(30)      ,/* 自由核算项二 */
bgbb027       varchar2(30)      ,/* 自由核算项三 */
bgbb028       varchar2(30)      ,/* 自由核算项四 */
bgbb029       varchar2(30)      ,/* 自由核算项五 */
bgbb030       varchar2(30)      ,/* 自由核算项六 */
bgbb031       varchar2(30)      ,/* 自由核算项七 */
bgbb032       varchar2(30)      ,/* 自由核算项八 */
bgbb033       varchar2(30)      ,/* 自由核算项九 */
bgbb034       varchar2(30)      ,/* 自由核算项十 */
bgbbud001       varchar2(40)      ,/* 自定义字段(文本)001 */
bgbbud002       varchar2(40)      ,/* 自定义字段(文本)002 */
bgbbud003       varchar2(40)      ,/* 自定义字段(文本)003 */
bgbbud004       varchar2(40)      ,/* 自定义字段(文本)004 */
bgbbud005       varchar2(40)      ,/* 自定义字段(文本)005 */
bgbbud006       varchar2(40)      ,/* 自定义字段(文本)006 */
bgbbud007       varchar2(40)      ,/* 自定义字段(文本)007 */
bgbbud008       varchar2(40)      ,/* 自定义字段(文本)008 */
bgbbud009       varchar2(40)      ,/* 自定义字段(文本)009 */
bgbbud010       varchar2(40)      ,/* 自定义字段(文本)010 */
bgbbud011       number(20,6)      ,/* 自定义字段(数字)011 */
bgbbud012       number(20,6)      ,/* 自定义字段(数字)012 */
bgbbud013       number(20,6)      ,/* 自定义字段(数字)013 */
bgbbud014       number(20,6)      ,/* 自定义字段(数字)014 */
bgbbud015       number(20,6)      ,/* 自定义字段(数字)015 */
bgbbud016       number(20,6)      ,/* 自定义字段(数字)016 */
bgbbud017       number(20,6)      ,/* 自定义字段(数字)017 */
bgbbud018       number(20,6)      ,/* 自定义字段(数字)018 */
bgbbud019       number(20,6)      ,/* 自定义字段(数字)019 */
bgbbud020       number(20,6)      ,/* 自定义字段(数字)020 */
bgbbud021       timestamp(0)      ,/* 自定义字段(日期时间)021 */
bgbbud022       timestamp(0)      ,/* 自定义字段(日期时间)022 */
bgbbud023       timestamp(0)      ,/* 自定义字段(日期时间)023 */
bgbbud024       timestamp(0)      ,/* 自定义字段(日期时间)024 */
bgbbud025       timestamp(0)      ,/* 自定义字段(日期时间)025 */
bgbbud026       timestamp(0)      ,/* 自定义字段(日期时间)026 */
bgbbud027       timestamp(0)      ,/* 自定义字段(日期时间)027 */
bgbbud028       timestamp(0)      ,/* 自定义字段(日期时间)028 */
bgbbud029       timestamp(0)      ,/* 自定义字段(日期时间)029 */
bgbbud030       timestamp(0)      /* 自定义字段(日期时间)030 */
);
alter table bgbb_t add constraint bgbb_pk primary key (bgbbent,bgbbdocno,bgbbseq) enable validate;

create unique index bgbb_pk on bgbb_t (bgbbent,bgbbdocno,bgbbseq);

grant select on bgbb_t to tiptop;
grant update on bgbb_t to tiptop;
grant delete on bgbb_t to tiptop;
grant insert on bgbb_t to tiptop;

exit;
