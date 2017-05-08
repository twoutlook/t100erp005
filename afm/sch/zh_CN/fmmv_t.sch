/* 
================================================================================
檔案代號:fmmv_t
檔案名稱:收息数据档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table fmmv_t
(
fmmvent       number(5)      ,/* 企业编号 */
fmmvsite       varchar2(10)      ,/* 投资组织 */
fmmvdocdt       date      ,/* 收息日期 */
fmmvdocno       varchar2(20)      ,/* 收息单号 */
fmmv001       varchar2(20)      ,/* 投资购买单号 */
fmmv002       date      ,/* 利息起算日期 */
fmmv003       date      ,/* 利息止算日期 */
fmmv004       varchar2(10)      ,/* 币种 */
fmmv005       number(20,6)      ,/* 金额 */
fmmv006       number(20,10)      ,/* 对主本币汇率 */
fmmv007       varchar2(1)      ,/* 收息方式 */
fmmv008       varchar2(20)      ,/* 银存收支单号 */
fmmv009       number(10,0)      ,/* 收支单项次 */
fmmvownid       varchar2(20)      ,/* 资料所有者 */
fmmvowndp       varchar2(10)      ,/* 资料所有部门 */
fmmvcrtid       varchar2(20)      ,/* 资料录入者 */
fmmvcrtdp       varchar2(10)      ,/* 资料录入部门 */
fmmvcrtdt       timestamp(0)      ,/* 资料创建日 */
fmmvmodid       varchar2(20)      ,/* 资料更改者 */
fmmvmoddt       timestamp(0)      ,/* 最近更改日 */
fmmvcnfid       varchar2(20)      ,/* 资料审核者 */
fmmvcnfdt       timestamp(0)      ,/* 数据审核日 */
fmmvpstid       varchar2(20)      ,/* 资料过账者 */
fmmvpstdt       timestamp(0)      ,/* 资料过账日 */
fmmvstus       varchar2(10)      ,/* 状态码 */
fmmvud001       varchar2(40)      ,/* 自定义字段(文本)001 */
fmmvud002       varchar2(40)      ,/* 自定义字段(文本)002 */
fmmvud003       varchar2(40)      ,/* 自定义字段(文本)003 */
fmmvud004       varchar2(40)      ,/* 自定义字段(文本)004 */
fmmvud005       varchar2(40)      ,/* 自定义字段(文本)005 */
fmmvud006       varchar2(40)      ,/* 自定义字段(文本)006 */
fmmvud007       varchar2(40)      ,/* 自定义字段(文本)007 */
fmmvud008       varchar2(40)      ,/* 自定义字段(文本)008 */
fmmvud009       varchar2(40)      ,/* 自定义字段(文本)009 */
fmmvud010       varchar2(40)      ,/* 自定义字段(文本)010 */
fmmvud011       number(20,6)      ,/* 自定义字段(数字)011 */
fmmvud012       number(20,6)      ,/* 自定义字段(数字)012 */
fmmvud013       number(20,6)      ,/* 自定义字段(数字)013 */
fmmvud014       number(20,6)      ,/* 自定义字段(数字)014 */
fmmvud015       number(20,6)      ,/* 自定义字段(数字)015 */
fmmvud016       number(20,6)      ,/* 自定义字段(数字)016 */
fmmvud017       number(20,6)      ,/* 自定义字段(数字)017 */
fmmvud018       number(20,6)      ,/* 自定义字段(数字)018 */
fmmvud019       number(20,6)      ,/* 自定义字段(数字)019 */
fmmvud020       number(20,6)      ,/* 自定义字段(数字)020 */
fmmvud021       timestamp(0)      ,/* 自定义字段(日期时间)021 */
fmmvud022       timestamp(0)      ,/* 自定义字段(日期时间)022 */
fmmvud023       timestamp(0)      ,/* 自定义字段(日期时间)023 */
fmmvud024       timestamp(0)      ,/* 自定义字段(日期时间)024 */
fmmvud025       timestamp(0)      ,/* 自定义字段(日期时间)025 */
fmmvud026       timestamp(0)      ,/* 自定义字段(日期时间)026 */
fmmvud027       timestamp(0)      ,/* 自定义字段(日期时间)027 */
fmmvud028       timestamp(0)      ,/* 自定义字段(日期时间)028 */
fmmvud029       timestamp(0)      ,/* 自定义字段(日期时间)029 */
fmmvud030       timestamp(0)      ,/* 自定义字段(日期时间)030 */
fmmv010       varchar2(20)      ,/* 转入投资购买单号 */
fmmv011       varchar2(10)      ,/* 现金变动码 */
fmmv012       varchar2(10)      ,/* 存提码 */
fmmv013       varchar2(10)      ,/* 支付账户 */
fmmv014       number(20,6)      ,/* 本币金额 */
fmmv015       varchar2(1)      ,/* 收息来源 */
fmmv016       number(20,6)      ,/* 冲销应计原币 */
fmmv017       number(20,6)      ,/* 冲销应计本币 */
fmmv018       number(20,6)      ,/* 利息收入原币 */
fmmv019       number(20,6)      ,/* 利息收入本币 */
fmmv020       number(20,6)      /* 汇差金额 */
);
alter table fmmv_t add constraint fmmv_pk primary key (fmmvent,fmmvdocno) enable validate;

create unique index fmmv_pk on fmmv_t (fmmvent,fmmvdocno);

grant select on fmmv_t to tiptop;
grant update on fmmv_t to tiptop;
grant delete on fmmv_t to tiptop;
grant insert on fmmv_t to tiptop;

exit;
