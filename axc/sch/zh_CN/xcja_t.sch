/* 
================================================================================
檔案代號:xcja_t
檔案名稱:内部交易计算基础设置
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table xcja_t
(
xcjaent       number(5)      ,/* 企业编号 */
xcja001       varchar2(10)      ,/* 计算类型(版本) */
xcja002       varchar2(1)      ,/* 主类型(版本)否 */
xcja003       varchar2(1)      ,/* 利润中心来源 */
xcja004       varchar2(1)      ,/* 类别 */
xcja005       varchar2(1)      ,/* 计算依据 */
xcja006       varchar2(10)      ,/* 核算币种 */
xcja007       varchar2(10)      ,/* 虚拟利润中心编号 */
xcja008       varchar2(1)      ,/* 计算方式 */
xcja009       varchar2(10)      ,/* 对比成本计算类型 */
xcja010       varchar2(1)      ,/* 结存是否计算内部成本 */
xcjaownid       varchar2(20)      ,/* 资料所有者 */
xcjaowndp       varchar2(10)      ,/* 资料所有部门 */
xcjacrtid       varchar2(20)      ,/* 资料录入者 */
xcjacrtdp       varchar2(10)      ,/* 资料录入部门 */
xcjacrtdt       timestamp(0)      ,/* 资料创建日 */
xcjamodid       varchar2(20)      ,/* 资料更改者 */
xcjamoddt       timestamp(0)      ,/* 最近更改日 */
xcjastus       varchar2(10)      ,/* 状态码 */
xcjaud001       varchar2(40)      ,/* 自定义字段(文本)001 */
xcjaud002       varchar2(40)      ,/* 自定义字段(文本)002 */
xcjaud003       varchar2(40)      ,/* 自定义字段(文本)003 */
xcjaud004       varchar2(40)      ,/* 自定义字段(文本)004 */
xcjaud005       varchar2(40)      ,/* 自定义字段(文本)005 */
xcjaud006       varchar2(40)      ,/* 自定义字段(文本)006 */
xcjaud007       varchar2(40)      ,/* 自定义字段(文本)007 */
xcjaud008       varchar2(40)      ,/* 自定义字段(文本)008 */
xcjaud009       varchar2(40)      ,/* 自定义字段(文本)009 */
xcjaud010       varchar2(40)      ,/* 自定义字段(文本)010 */
xcjaud011       number(20,6)      ,/* 自定义字段(数字)011 */
xcjaud012       number(20,6)      ,/* 自定义字段(数字)012 */
xcjaud013       number(20,6)      ,/* 自定义字段(数字)013 */
xcjaud014       number(20,6)      ,/* 自定义字段(数字)014 */
xcjaud015       number(20,6)      ,/* 自定义字段(数字)015 */
xcjaud016       number(20,6)      ,/* 自定义字段(数字)016 */
xcjaud017       number(20,6)      ,/* 自定义字段(数字)017 */
xcjaud018       number(20,6)      ,/* 自定义字段(数字)018 */
xcjaud019       number(20,6)      ,/* 自定义字段(数字)019 */
xcjaud020       number(20,6)      ,/* 自定义字段(数字)020 */
xcjaud021       timestamp(0)      ,/* 自定义字段(日期时间)021 */
xcjaud022       timestamp(0)      ,/* 自定义字段(日期时间)022 */
xcjaud023       timestamp(0)      ,/* 自定义字段(日期时间)023 */
xcjaud024       timestamp(0)      ,/* 自定义字段(日期时间)024 */
xcjaud025       timestamp(0)      ,/* 自定义字段(日期时间)025 */
xcjaud026       timestamp(0)      ,/* 自定义字段(日期时间)026 */
xcjaud027       timestamp(0)      ,/* 自定义字段(日期时间)027 */
xcjaud028       timestamp(0)      ,/* 自定义字段(日期时间)028 */
xcjaud029       timestamp(0)      ,/* 自定义字段(日期时间)029 */
xcjaud030       timestamp(0)      ,/* 自定义字段(日期时间)030 */
xcja011       varchar2(1)      /* 成本调整取价 */
);
alter table xcja_t add constraint xcja_pk primary key (xcjaent,xcja001) enable validate;

create unique index xcja_pk on xcja_t (xcjaent,xcja001);

grant select on xcja_t to tiptop;
grant update on xcja_t to tiptop;
grant delete on xcja_t to tiptop;
grant insert on xcja_t to tiptop;

exit;
