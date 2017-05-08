/* 
================================================================================
檔案代號:nmbc_t
檔案名稱:银存收支异动档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table nmbc_t
(
nmbcent       number(5)      ,/* 企业编号 */
nmbcownid       varchar2(20)      ,/* 资料所有者 */
nmbcowndp       varchar2(10)      ,/* 资料所有部门 */
nmbccrtid       varchar2(20)      ,/* 资料录入者 */
nmbccrtdp       varchar2(10)      ,/* 资料录入部门 */
nmbccrtdt       timestamp(0)      ,/* 资料创建日 */
nmbcmodid       varchar2(20)      ,/* 资料更改者 */
nmbcmoddt       timestamp(0)      ,/* 最近更改日 */
nmbccnfid       varchar2(20)      ,/* 资料审核者 */
nmbccnfdt       timestamp(0)      ,/* 数据审核日 */
nmbcpstid       varchar2(20)      ,/* 资料过账者 */
nmbcpstdt       timestamp(0)      ,/* 资料过账日 */
nmbcstus       varchar2(10)      ,/* 状态码 */
nmbccomp       varchar2(10)      ,/* 法人 */
nmbcsite       varchar2(10)      ,/* 资金中心 */
nmbcdocno       varchar2(20)      ,/* 来源单号 */
nmbcseq       number(10,0)      ,/* 项次 */
nmbc001       varchar2(10)      ,/* 单据来源 */
nmbc002       varchar2(10)      ,/* 交易账户编码 */
nmbc003       varchar2(10)      ,/* 交易对象 */
nmbc004       varchar2(20)      ,/* 交易对象识别码 */
nmbc005       date      ,/* 银行日期 */
nmbc006       varchar2(1)      ,/* 异动别 */
nmbc007       varchar2(10)      ,/* 存提码 */
nmbc008       varchar2(10)      ,/* 调节码 */
nmbc009       varchar2(10)      ,/* 对账码 */
nmbc010       date      ,/* 网银媒体档转出日期 */
nmbc011       varchar2(20)      ,/* 网银媒体档转出批号 */
nmbc100       varchar2(10)      ,/* 交易帐户币种 */
nmbc101       number(20,10)      ,/* 主账套汇率 */
nmbc103       number(20,6)      ,/* 主账套原币金额 */
nmbc113       number(20,6)      ,/* 主账套本币金额 */
nmbc121       number(20,10)      ,/* 主账套本位币二汇率 */
nmbc123       number(20,6)      ,/* 主账套本位币二金额 */
nmbc131       number(20,10)      ,/* 主账套本位币三汇率 */
nmbc133       number(20,6)      ,/* 主账套本位币三金额 */
nmbcud001       varchar2(40)      ,/* 自定义字段(文本)001 */
nmbcud002       varchar2(40)      ,/* 自定义字段(文本)002 */
nmbcud003       varchar2(40)      ,/* 自定义字段(文本)003 */
nmbcud004       varchar2(40)      ,/* 自定义字段(文本)004 */
nmbcud005       varchar2(40)      ,/* 自定义字段(文本)005 */
nmbcud006       varchar2(40)      ,/* 自定义字段(文本)006 */
nmbcud007       varchar2(40)      ,/* 自定义字段(文本)007 */
nmbcud008       varchar2(40)      ,/* 自定义字段(文本)008 */
nmbcud009       varchar2(40)      ,/* 自定义字段(文本)009 */
nmbcud010       varchar2(40)      ,/* 自定义字段(文本)010 */
nmbcud011       number(20,6)      ,/* 自定义字段(数字)011 */
nmbcud012       number(20,6)      ,/* 自定义字段(数字)012 */
nmbcud013       number(20,6)      ,/* 自定义字段(数字)013 */
nmbcud014       number(20,6)      ,/* 自定义字段(数字)014 */
nmbcud015       number(20,6)      ,/* 自定义字段(数字)015 */
nmbcud016       number(20,6)      ,/* 自定义字段(数字)016 */
nmbcud017       number(20,6)      ,/* 自定义字段(数字)017 */
nmbcud018       number(20,6)      ,/* 自定义字段(数字)018 */
nmbcud019       number(20,6)      ,/* 自定义字段(数字)019 */
nmbcud020       number(20,6)      ,/* 自定义字段(数字)020 */
nmbcud021       timestamp(0)      ,/* 自定义字段(日期时间)021 */
nmbcud022       timestamp(0)      ,/* 自定义字段(日期时间)022 */
nmbcud023       timestamp(0)      ,/* 自定义字段(日期时间)023 */
nmbcud024       timestamp(0)      ,/* 自定义字段(日期时间)024 */
nmbcud025       timestamp(0)      ,/* 自定义字段(日期时间)025 */
nmbcud026       timestamp(0)      ,/* 自定义字段(日期时间)026 */
nmbcud027       timestamp(0)      ,/* 自定义字段(日期时间)027 */
nmbcud028       timestamp(0)      ,/* 自定义字段(日期时间)028 */
nmbcud029       timestamp(0)      ,/* 自定义字段(日期时间)029 */
nmbcud030       timestamp(0)      ,/* 自定义字段(日期时间)030 */
nmbc012       varchar2(20)      ,/* 票据号码 */
nmbc013       varchar2(10)      ,/* 款别 */
nmbc014       date      ,/* 到期日 */
nmbc015       varchar2(15)      ,/* 导入银行编号 */
nmbc016       varchar2(30)      ,/* 导入帐号 */
nmbc017       varchar2(255)      ,/* 受款人全名 */
nmbcorga       varchar2(10)      /* 来源组织 */
);
alter table nmbc_t add constraint nmbc_pk primary key (nmbcent,nmbccomp,nmbcdocno,nmbcseq,nmbc002) enable validate;

create  index nmbc_01 on nmbc_t (nmbccomp,nmbcent,nmbc001);
create  index nmbc_n02 on nmbc_t (nmbcent,nmbccomp,nmbc003,nmbc012);
create unique index nmbc_pk on nmbc_t (nmbcent,nmbccomp,nmbcdocno,nmbcseq,nmbc002);

grant select on nmbc_t to tiptop;
grant update on nmbc_t to tiptop;
grant delete on nmbc_t to tiptop;
grant insert on nmbc_t to tiptop;

exit;
