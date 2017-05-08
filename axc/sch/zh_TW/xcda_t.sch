/* 
================================================================================
檔案代號:xcda_t
檔案名稱:期初库存数量成本要素成本开账档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table xcda_t
(
xcdaent       number(5)      ,/* 企业编号 */
xcdald       varchar2(5)      ,/* 账套 */
xcdacomp       varchar2(10)      ,/* 法人组织 */
xcda001       varchar2(1)      ,/* 账套本位币顺序 */
xcda002       varchar2(30)      ,/* 成本域 */
xcda003       varchar2(10)      ,/* 成本计算类型 */
xcda004       number(5,0)      ,/* 年度 */
xcda005       number(5,0)      ,/* 期别 */
xcda006       varchar2(40)      ,/* 料号 */
xcda007       varchar2(256)      ,/* 特性 */
xcda008       varchar2(30)      ,/* 批号 */
xcda009       varchar2(10)      ,/* 成本次要素 */
xcda101       number(20,6)      ,/* 当月期末数量 */
xcda102       number(20,6)      ,/* 当月期末金额-金额合计 */
xcdaownid       varchar2(20)      ,/* 资料所有者 */
xcdaowndp       varchar2(10)      ,/* 资料所有部门 */
xcdacrtid       varchar2(20)      ,/* 资料录入者 */
xcdacrtdp       varchar2(10)      ,/* 资料录入部门 */
xcdacrtdt       timestamp(0)      ,/* 资料创建日 */
xcdamodid       varchar2(20)      ,/* 资料更改者 */
xcdamoddt       timestamp(0)      ,/* 最近更改日 */
xcdacnfid       varchar2(20)      ,/* 资料审核者 */
xcdacnfdt       timestamp(0)      ,/* 数据审核日 */
xcdapstid       varchar2(20)      ,/* 资料过账者 */
xcdapstdt       timestamp(0)      ,/* 资料过账日 */
xcdastus       varchar2(10)      ,/* 状态码 */
xcdaud001       varchar2(40)      ,/* 自定义字段(文本)001 */
xcdaud002       varchar2(40)      ,/* 自定义字段(文本)002 */
xcdaud003       varchar2(40)      ,/* 自定义字段(文本)003 */
xcdaud004       varchar2(40)      ,/* 自定义字段(文本)004 */
xcdaud005       varchar2(40)      ,/* 自定义字段(文本)005 */
xcdaud006       varchar2(40)      ,/* 自定义字段(文本)006 */
xcdaud007       varchar2(40)      ,/* 自定义字段(文本)007 */
xcdaud008       varchar2(40)      ,/* 自定义字段(文本)008 */
xcdaud009       varchar2(40)      ,/* 自定义字段(文本)009 */
xcdaud010       varchar2(40)      ,/* 自定义字段(文本)010 */
xcdaud011       number(20,6)      ,/* 自定义字段(数字)011 */
xcdaud012       number(20,6)      ,/* 自定义字段(数字)012 */
xcdaud013       number(20,6)      ,/* 自定义字段(数字)013 */
xcdaud014       number(20,6)      ,/* 自定义字段(数字)014 */
xcdaud015       number(20,6)      ,/* 自定义字段(数字)015 */
xcdaud016       number(20,6)      ,/* 自定义字段(数字)016 */
xcdaud017       number(20,6)      ,/* 自定义字段(数字)017 */
xcdaud018       number(20,6)      ,/* 自定义字段(数字)018 */
xcdaud019       number(20,6)      ,/* 自定义字段(数字)019 */
xcdaud020       number(20,6)      ,/* 自定义字段(数字)020 */
xcdaud021       timestamp(0)      ,/* 自定义字段(日期时间)021 */
xcdaud022       timestamp(0)      ,/* 自定义字段(日期时间)022 */
xcdaud023       timestamp(0)      ,/* 自定义字段(日期时间)023 */
xcdaud024       timestamp(0)      ,/* 自定义字段(日期时间)024 */
xcdaud025       timestamp(0)      ,/* 自定义字段(日期时间)025 */
xcdaud026       timestamp(0)      ,/* 自定义字段(日期时间)026 */
xcdaud027       timestamp(0)      ,/* 自定义字段(日期时间)027 */
xcdaud028       timestamp(0)      ,/* 自定义字段(日期时间)028 */
xcdaud029       timestamp(0)      ,/* 自定义字段(日期时间)029 */
xcdaud030       timestamp(0)      ,/* 自定义字段(日期时间)030 */
xcda110       number(20,6)      /* 当月期末金额-平均单价 */
);
alter table xcda_t add constraint xcda_pk primary key (xcdaent,xcdald,xcda001,xcda002,xcda003,xcda004,xcda005,xcda006,xcda007,xcda008,xcda009) enable validate;

create  index xcda_n1 on xcda_t (xcdaent,xcdald,xcda001,xcda002,xcda003,xcda004,xcda005,xcda006,xcda007,xcda008);
create unique index xcda_pk on xcda_t (xcdaent,xcdald,xcda001,xcda002,xcda003,xcda004,xcda005,xcda006,xcda007,xcda008,xcda009);

grant select on xcda_t to tiptop;
grant update on xcda_t to tiptop;
grant delete on xcda_t to tiptop;
grant insert on xcda_t to tiptop;

exit;
