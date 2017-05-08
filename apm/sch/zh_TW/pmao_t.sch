/* 
================================================================================
檔案代號:pmao_t
檔案名稱:交易对象料号对应档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table pmao_t
(
pmaoent       number(5)      ,/* 企业编号 */
pmaoownid       varchar2(20)      ,/* 资料所有者 */
pmaoowndp       varchar2(10)      ,/* 资料所有部门 */
pmaocrtid       varchar2(20)      ,/* 资料录入者 */
pmaocrtdp       varchar2(10)      ,/* 资料录入部门 */
pmaocrtdt       timestamp(0)      ,/* 资料创建日 */
pmaomodid       varchar2(20)      ,/* 资料更改者 */
pmaomoddt       timestamp(0)      ,/* 最近更改日 */
pmaostus       varchar2(10)      ,/* 状态码 */
pmao001       varchar2(10)      ,/* 交易对象编号 */
pmao002       varchar2(40)      ,/* 公司料件编号 */
pmao003       varchar2(256)      ,/* 产品特征 */
pmao004       varchar2(40)      ,/* 交易对象料件编号 */
pmao005       varchar2(255)      ,/* 简要说明 */
pmao006       varchar2(20)      ,/* 参考单号 */
pmao007       varchar2(1)      ,/* 主要对应料号否 */
pmao008       number(20,6)      ,/* no use */
pmao009       varchar2(255)      ,/* 交易对象料件品名 */
pmaoud001       varchar2(40)      ,/* 自定义字段(文本)001 */
pmaoud002       varchar2(40)      ,/* 自定义字段(文本)002 */
pmaoud003       varchar2(40)      ,/* 自定义字段(文本)003 */
pmaoud004       varchar2(40)      ,/* 自定义字段(文本)004 */
pmaoud005       varchar2(40)      ,/* 自定义字段(文本)005 */
pmaoud006       varchar2(40)      ,/* 自定义字段(文本)006 */
pmaoud007       varchar2(40)      ,/* 自定义字段(文本)007 */
pmaoud008       varchar2(40)      ,/* 自定义字段(文本)008 */
pmaoud009       varchar2(40)      ,/* 自定义字段(文本)009 */
pmaoud010       varchar2(40)      ,/* 自定义字段(文本)010 */
pmaoud011       number(20,6)      ,/* 自定义字段(数字)011 */
pmaoud012       number(20,6)      ,/* 自定义字段(数字)012 */
pmaoud013       number(20,6)      ,/* 自定义字段(数字)013 */
pmaoud014       number(20,6)      ,/* 自定义字段(数字)014 */
pmaoud015       number(20,6)      ,/* 自定义字段(数字)015 */
pmaoud016       number(20,6)      ,/* 自定义字段(数字)016 */
pmaoud017       number(20,6)      ,/* 自定义字段(数字)017 */
pmaoud018       number(20,6)      ,/* 自定义字段(数字)018 */
pmaoud019       number(20,6)      ,/* 自定义字段(数字)019 */
pmaoud020       number(20,6)      ,/* 自定义字段(数字)020 */
pmaoud021       timestamp(0)      ,/* 自定义字段(日期时间)021 */
pmaoud022       timestamp(0)      ,/* 自定义字段(日期时间)022 */
pmaoud023       timestamp(0)      ,/* 自定义字段(日期时间)023 */
pmaoud024       timestamp(0)      ,/* 自定义字段(日期时间)024 */
pmaoud025       timestamp(0)      ,/* 自定义字段(日期时间)025 */
pmaoud026       timestamp(0)      ,/* 自定义字段(日期时间)026 */
pmaoud027       timestamp(0)      ,/* 自定义字段(日期时间)027 */
pmaoud028       timestamp(0)      ,/* 自定义字段(日期时间)028 */
pmaoud029       timestamp(0)      ,/* 自定义字段(日期时间)029 */
pmaoud030       timestamp(0)      ,/* 自定义字段(日期时间)030 */
pmao010       varchar2(255)      ,/* 交易对象料件规格 */
pmao000       varchar2(1)      /* 类别 */
);
alter table pmao_t add constraint pmao_pk primary key (pmaoent,pmao001,pmao002,pmao003,pmao004,pmao000) enable validate;

create unique index pmao_pk on pmao_t (pmaoent,pmao001,pmao002,pmao003,pmao004,pmao000);

grant select on pmao_t to tiptop;
grant update on pmao_t to tiptop;
grant delete on pmao_t to tiptop;
grant insert on pmao_t to tiptop;

exit;
