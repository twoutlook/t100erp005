/* 
================================================================================
檔案代號:bgae_t
檔案名稱:预算项目档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table bgae_t
(
bgaeent       number(5)      ,/* 企业编号 */
bgae006       varchar2(5)      ,/* 预算细项参照表号 */
bgae001       varchar2(24)      ,/* 预算细项编码 */
bgae007       varchar2(1)      ,/* 类别 */
bgae002       varchar2(1)      ,/* 借贷方向 */
bgae003       varchar2(1)      ,/* 资产损益别 */
bgae004       varchar2(1)      ,/* 计量方式 */
bgae005       varchar2(10)      ,/* 所属预算大类 */
bgae008       varchar2(10)      ,/* 预算分类 */
bgae009       varchar2(24)      ,/* 起始预算细项 */
bgae010       varchar2(24)      ,/* 截止预算细项 */
bgae011       varchar2(1)      ,/* 计量方式 */
bgae012       varchar2(1)      ,/* 金额来源 */
bgae013       varchar2(256)      ,/* 计算公式 */
bgae014       varchar2(1)      ,/* 数据格式 */
bgae015       varchar2(1)      ,/* 部门 */
bgae016       varchar2(1)      ,/* 利润中心 */
bgae017       varchar2(1)      ,/* 区域 */
bgae018       varchar2(1)      ,/* 交易客商 */
bgae019       varchar2(1)      ,/* 收款客商 */
bgae020       varchar2(1)      ,/* 客群 */
bgae021       varchar2(1)      ,/* 产品类别 */
bgae022       varchar2(1)      ,/* 人员 */
bgae023       varchar2(1)      ,/* 项目编号 */
bgae024       varchar2(1)      ,/* WBS */
bgae025       varchar2(1)      ,/* 经营方式 */
bgae026       varchar2(1)      ,/* 自由核算项一 */
bgae027       varchar2(1)      ,/* 自由核算项二 */
bgae028       varchar2(1)      ,/* 自由核算项三 */
bgae029       varchar2(1)      ,/* 自由核算项四 */
bgae030       varchar2(1)      ,/* 自由核算项五 */
bgae031       varchar2(1)      ,/* 自由核算项六 */
bgae032       varchar2(1)      ,/* 自由核算项七 */
bgae033       varchar2(1)      ,/* 自由核算项八 */
bgae034       varchar2(1)      ,/* 自由核算项九 */
bgae035       varchar2(1)      ,/* 自由核算项十 */
bgae036       varchar2(1)      ,/* 现金类项目 */
bgae037       varchar2(1)      ,/* 期别 */
bgaeownid       varchar2(20)      ,/* 资料所有者 */
bgaeowndp       varchar2(10)      ,/* 资料所有部门 */
bgaecrtid       varchar2(20)      ,/* 资料录入者 */
bgaecrtdp       varchar2(10)      ,/* 资料录入部门 */
bgaecrtdt       timestamp(0)      ,/* 资料创建日 */
bgaemodid       varchar2(20)      ,/* 资料更改者 */
bgaemoddt       timestamp(0)      ,/* 最近更改日 */
bgaestus       varchar2(10)      ,/* 状态码 */
bgae038       varchar2(255)      ,/* 计算公式说明 */
bgaeud001       varchar2(40)      ,/* 自定义字段(文本)001 */
bgaeud002       varchar2(40)      ,/* 自定义字段(文本)002 */
bgaeud003       varchar2(40)      ,/* 自定义字段(文本)003 */
bgaeud004       varchar2(40)      ,/* 自定义字段(文本)004 */
bgaeud005       varchar2(40)      ,/* 自定义字段(文本)005 */
bgaeud006       varchar2(40)      ,/* 自定义字段(文本)006 */
bgaeud007       varchar2(40)      ,/* 自定义字段(文本)007 */
bgaeud008       varchar2(40)      ,/* 自定义字段(文本)008 */
bgaeud009       varchar2(40)      ,/* 自定义字段(文本)009 */
bgaeud010       varchar2(40)      ,/* 自定义字段(文本)010 */
bgaeud011       number(20,6)      ,/* 自定义字段(数字)011 */
bgaeud012       number(20,6)      ,/* 自定义字段(数字)012 */
bgaeud013       number(20,6)      ,/* 自定义字段(数字)013 */
bgaeud014       number(20,6)      ,/* 自定义字段(数字)014 */
bgaeud015       number(20,6)      ,/* 自定义字段(数字)015 */
bgaeud016       number(20,6)      ,/* 自定义字段(数字)016 */
bgaeud017       number(20,6)      ,/* 自定义字段(数字)017 */
bgaeud018       number(20,6)      ,/* 自定义字段(数字)018 */
bgaeud019       number(20,6)      ,/* 自定义字段(数字)019 */
bgaeud020       number(20,6)      ,/* 自定义字段(数字)020 */
bgaeud021       timestamp(0)      ,/* 自定义字段(日期时间)021 */
bgaeud022       timestamp(0)      ,/* 自定义字段(日期时间)022 */
bgaeud023       timestamp(0)      ,/* 自定义字段(日期时间)023 */
bgaeud024       timestamp(0)      ,/* 自定义字段(日期时间)024 */
bgaeud025       timestamp(0)      ,/* 自定义字段(日期时间)025 */
bgaeud026       timestamp(0)      ,/* 自定义字段(日期时间)026 */
bgaeud027       timestamp(0)      ,/* 自定义字段(日期时间)027 */
bgaeud028       timestamp(0)      ,/* 自定义字段(日期时间)028 */
bgaeud029       timestamp(0)      ,/* 自定义字段(日期时间)029 */
bgaeud030       timestamp(0)      ,/* 自定义字段(日期时间)030 */
bgae039       varchar2(1)      ,/* 关键指标 */
bgae040       varchar2(1)      ,/* 渠道 */
bgae041       varchar2(1)      /* 品牌 */
);
alter table bgae_t add constraint bgae_pk primary key (bgaeent,bgae006,bgae001) enable validate;

create unique index bgae_pk on bgae_t (bgaeent,bgae006,bgae001);

grant select on bgae_t to tiptop;
grant update on bgae_t to tiptop;
grant delete on bgae_t to tiptop;
grant insert on bgae_t to tiptop;

exit;
