/* 
================================================================================
檔案代號:pjeb_t
檔案名稱:项目费用收集维护档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table pjeb_t
(
pjebent       number(5)      ,/* 企业编号 */
pjebcomp       varchar2(10)      ,/* 法人组织 */
pjebld       varchar2(5)      ,/* 账套 */
pjeb002       number(5,0)      ,/* 年度 */
pjeb003       number(5,0)      ,/* 期别 */
pjebseq       number(10,0)      ,/* 项次 */
pjeb010       varchar2(24)      ,/* 科目编号 */
pjeb011       varchar2(10)      ,/* 营运组织 */
pjeb012       varchar2(10)      ,/* 部门 */
pjeb013       varchar2(10)      ,/* 交易对象 */
pjeb014       varchar2(10)      ,/* 客群 */
pjeb015       varchar2(10)      ,/* 区域 */
pjeb016       varchar2(10)      ,/* 成本中心 */
pjeb017       varchar2(10)      ,/* 经营类别 */
pjeb018       varchar2(10)      ,/* 渠道 */
pjeb019       varchar2(10)      ,/* 品类 */
pjeb020       varchar2(10)      ,/* 品牌 */
pjeb021       varchar2(20)      ,/* 项目编号(核算项) */
pjeb022       varchar2(30)      ,/* WBS(核算项) */
pjeb100       number(20,6)      ,/* 分摊金额 */
pjeb110       number(20,6)      ,/* 分摊金额(本位币二) */
pjeb120       number(20,6)      ,/* 分摊金额(本位币三) */
pjeb200       number(20,6)      ,/* 分摊基数 */
pjeb300       number(20,6)      ,/* 分摊单价 */
pjeb310       number(20,6)      ,/* 分摊单价(本位币二) */
pjeb320       number(20,6)      ,/* 分摊单价(本位币三) */
pjebownid       varchar2(20)      ,/* 资料所有者 */
pjebowndp       varchar2(10)      ,/* 资料所属部门 */
pjebcrtid       varchar2(20)      ,/* 资料录入者 */
pjebcrtdp       varchar2(10)      ,/* 资料录入部门 */
pjebcrtdt       timestamp(0)      ,/* 资料创建日 */
pjebmodid       varchar2(20)      ,/* 资料更改者 */
pjebmoddt       timestamp(0)      ,/* 最近更改日 */
pjebstus       varchar2(10)      ,/* 状态码 */
pjebud001       varchar2(40)      ,/* 自定义字段(文本)001 */
pjebud002       varchar2(40)      ,/* 自定义字段(文本)002 */
pjebud003       varchar2(40)      ,/* 自定义字段(文本)003 */
pjebud004       varchar2(40)      ,/* 自定义字段(文本)004 */
pjebud005       varchar2(40)      ,/* 自定义字段(文本)005 */
pjebud006       varchar2(40)      ,/* 自定义字段(文本)006 */
pjebud007       varchar2(40)      ,/* 自定义字段(文本)007 */
pjebud008       varchar2(40)      ,/* 自定义字段(文本)008 */
pjebud009       varchar2(40)      ,/* 自定义字段(文本)009 */
pjebud010       varchar2(40)      ,/* 自定义字段(文本)010 */
pjebud011       number(20,6)      ,/* 自定义字段(数字)011 */
pjebud012       number(20,6)      ,/* 自定义字段(数字)012 */
pjebud013       number(20,6)      ,/* 自定义字段(数字)013 */
pjebud014       number(20,6)      ,/* 自定义字段(数字)014 */
pjebud015       number(20,6)      ,/* 自定义字段(数字)015 */
pjebud016       number(20,6)      ,/* 自定义字段(数字)016 */
pjebud017       number(20,6)      ,/* 自定义字段(数字)017 */
pjebud018       number(20,6)      ,/* 自定义字段(数字)018 */
pjebud019       number(20,6)      ,/* 自定义字段(数字)019 */
pjebud020       number(20,6)      ,/* 自定义字段(数字)020 */
pjebud021       timestamp(0)      ,/* 自定义字段(日期时间)021 */
pjebud022       timestamp(0)      ,/* 自定义字段(日期时间)022 */
pjebud023       timestamp(0)      ,/* 自定义字段(日期时间)023 */
pjebud024       timestamp(0)      ,/* 自定义字段(日期时间)024 */
pjebud025       timestamp(0)      ,/* 自定义字段(日期时间)025 */
pjebud026       timestamp(0)      ,/* 自定义字段(日期时间)026 */
pjebud027       timestamp(0)      ,/* 自定义字段(日期时间)027 */
pjebud028       timestamp(0)      ,/* 自定义字段(日期时间)028 */
pjebud029       timestamp(0)      ,/* 自定义字段(日期时间)029 */
pjebud030       timestamp(0)      /* 自定义字段(日期时间)030 */
);
alter table pjeb_t add constraint pjeb_pk primary key (pjebent,pjebld,pjeb002,pjeb003,pjebseq) enable validate;

create unique index pjeb_pk on pjeb_t (pjebent,pjebld,pjeb002,pjeb003,pjebseq);

grant select on pjeb_t to tiptop;
grant update on pjeb_t to tiptop;
grant delete on pjeb_t to tiptop;
grant insert on pjeb_t to tiptop;

exit;
