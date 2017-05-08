/* 
================================================================================
檔案代號:bgbf_t
檔案名稱:预算挪用档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table bgbf_t
(
bgbfent       number(5)      ,/* 企业编号 */
bgbfdocdt       date      ,/* 单据日期 */
bgbfdocno       varchar2(20)      ,/* 挪用单号 */
bgbfsite       varchar2(10)      ,/* 申请组织 */
bgbf005       varchar2(255)      ,/* 摘要 */
bgbf001       varchar2(10)      ,/* 预算编号a */
bgbf101       varchar2(10)      ,/* 预算编号b */
bgbf002       varchar2(10)      ,/* 预算版本a */
bgbf102       varchar2(10)      ,/* 预算版本b */
bgbf003       varchar2(10)      ,/* 预算组织a */
bgbf103       varchar2(10)      ,/* 预算组织b */
bgbf004       varchar2(24)      ,/* 预算细项a */
bgbf104       varchar2(24)      ,/* 预算细项b */
bgbf006       number(5,0)      ,/* 预算期别a */
bgbf106       number(5,0)      ,/* 预算期别b */
bgbf007       varchar2(10)      ,/* 部门a */
bgbf107       varchar2(10)      ,/* 部门b */
bgbf008       varchar2(10)      ,/* 成本利润中心a */
bgbf108       varchar2(10)      ,/* 成本利润中心b */
bgbf009       varchar2(10)      ,/* 区域a */
bgbf109       varchar2(10)      ,/* 区域b */
bgbf010       varchar2(10)      ,/* 交易客商a */
bgbf110       varchar2(10)      ,/* 交易客商b */
bgbf011       varchar2(10)      ,/* 收款客商a */
bgbf111       varchar2(10)      ,/* 收款客商b */
bgbf012       varchar2(10)      ,/* 客群a */
bgbf112       varchar2(10)      ,/* 客群b */
bgbf013       varchar2(10)      ,/* 产品类别a */
bgbf113       varchar2(10)      ,/* 产品类别b */
bgbf014       varchar2(20)      ,/* 人员a */
bgbf114       varchar2(20)      ,/* 人员b */
bgbf015       varchar2(20)      ,/* 项目编号a */
bgbf115       varchar2(20)      ,/* 项目编号b */
bgbf016       varchar2(30)      ,/* WBSa */
bgbf116       varchar2(30)      ,/* WBSb */
bgbf017       varchar2(10)      ,/* 经营方式a */
bgbf117       varchar2(10)      ,/* 经营方式b */
bgbf018       varchar2(10)      ,/* 渠道a */
bgbf118       varchar2(10)      ,/* 渠道b */
bgbf019       varchar2(10)      ,/* 品牌a */
bgbf119       varchar2(10)      ,/* 品牌b */
bgbf020       varchar2(30)      ,/* 自由核算项一a */
bgbf120       varchar2(30)      ,/* 自由核算项一b */
bgbf021       varchar2(30)      ,/* 自由核算项二a */
bgbf121       varchar2(30)      ,/* 自由核算项二b */
bgbf022       varchar2(30)      ,/* 自由核算项三a */
bgbf122       varchar2(30)      ,/* 自由核算项三b */
bgbf023       varchar2(30)      ,/* 自由核算项四a */
bgbf123       varchar2(30)      ,/* 自由核算项四b */
bgbf024       varchar2(30)      ,/* 自由核算项五a */
bgbf124       varchar2(30)      ,/* 自由核算项五b */
bgbf025       varchar2(30)      ,/* 自由核算项六a */
bgbf125       varchar2(30)      ,/* 自由核算项六b */
bgbf026       varchar2(30)      ,/* 自由核算项七a */
bgbf126       varchar2(30)      ,/* 自由核算项七b */
bgbf027       varchar2(30)      ,/* 自由核算项八a */
bgbf127       varchar2(30)      ,/* 自由核算项八b */
bgbf028       varchar2(30)      ,/* 自由核算项九a */
bgbf128       varchar2(30)      ,/* 自由核算项九b */
bgbf029       varchar2(30)      ,/* 自由核算项十a */
bgbf129       varchar2(30)      ,/* 自由核算项十b */
bgbf030       number(20,6)      ,/* 挪出金额 */
bgbf130       number(20,6)      ,/* 挪入金额 */
bgbf031       number(20,10)      ,/* 汇率 */
bgbf032       number(5,0)      ,/* 滚动期别a */
bgbf033       number(5,0)      ,/* 滚动期别b */
bgbfownid       varchar2(20)      ,/* 资料所有者 */
bgbfowndp       varchar2(10)      ,/* 资料所有部门 */
bgbfcrtid       varchar2(20)      ,/* 资料录入者 */
bgbfcrtdp       varchar2(10)      ,/* 资料录入部门 */
bgbfcrtdt       timestamp(0)      ,/* 资料创建日 */
bgbfmodid       varchar2(20)      ,/* 资料更改者 */
bgbfmoddt       timestamp(0)      ,/* 最近更改日 */
bgbfcnfid       varchar2(20)      ,/* 资料审核者 */
bgbfcnfdt       timestamp(0)      ,/* 数据审核日 */
bgbfpstid       varchar2(20)      ,/* 资料过账者 */
bgbfpstdt       timestamp(0)      ,/* 资料过账日 */
bgbfstus       varchar2(10)      ,/* 状态码 */
bgbfud001       varchar2(40)      ,/* 自定义字段(文本)001 */
bgbfud002       varchar2(40)      ,/* 自定义字段(文本)002 */
bgbfud003       varchar2(40)      ,/* 自定义字段(文本)003 */
bgbfud004       varchar2(40)      ,/* 自定义字段(文本)004 */
bgbfud005       varchar2(40)      ,/* 自定义字段(文本)005 */
bgbfud006       varchar2(40)      ,/* 自定义字段(文本)006 */
bgbfud007       varchar2(40)      ,/* 自定义字段(文本)007 */
bgbfud008       varchar2(40)      ,/* 自定义字段(文本)008 */
bgbfud009       varchar2(40)      ,/* 自定义字段(文本)009 */
bgbfud010       varchar2(40)      ,/* 自定义字段(文本)010 */
bgbfud011       number(20,6)      ,/* 自定义字段(数字)011 */
bgbfud012       number(20,6)      ,/* 自定义字段(数字)012 */
bgbfud013       number(20,6)      ,/* 自定义字段(数字)013 */
bgbfud014       number(20,6)      ,/* 自定义字段(数字)014 */
bgbfud015       number(20,6)      ,/* 自定义字段(数字)015 */
bgbfud016       number(20,6)      ,/* 自定义字段(数字)016 */
bgbfud017       number(20,6)      ,/* 自定义字段(数字)017 */
bgbfud018       number(20,6)      ,/* 自定义字段(数字)018 */
bgbfud019       number(20,6)      ,/* 自定义字段(数字)019 */
bgbfud020       number(20,6)      ,/* 自定义字段(数字)020 */
bgbfud021       timestamp(0)      ,/* 自定义字段(日期时间)021 */
bgbfud022       timestamp(0)      ,/* 自定义字段(日期时间)022 */
bgbfud023       timestamp(0)      ,/* 自定义字段(日期时间)023 */
bgbfud024       timestamp(0)      ,/* 自定义字段(日期时间)024 */
bgbfud025       timestamp(0)      ,/* 自定义字段(日期时间)025 */
bgbfud026       timestamp(0)      ,/* 自定义字段(日期时间)026 */
bgbfud027       timestamp(0)      ,/* 自定义字段(日期时间)027 */
bgbfud028       timestamp(0)      ,/* 自定义字段(日期时间)028 */
bgbfud029       timestamp(0)      ,/* 自定义字段(日期时间)029 */
bgbfud030       timestamp(0)      /* 自定义字段(日期时间)030 */
);
alter table bgbf_t add constraint bgbf_pk primary key (bgbfent,bgbfdocno) enable validate;

create unique index bgbf_pk on bgbf_t (bgbfent,bgbfdocno);

grant select on bgbf_t to tiptop;
grant update on bgbf_t to tiptop;
grant delete on bgbf_t to tiptop;
grant insert on bgbf_t to tiptop;

exit;
