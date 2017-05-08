/* 
================================================================================
檔案代號:bcba_t
檔案名稱:条码规则主档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table bcba_t
(
bcbaent       number(5)      ,/* 企业代码 */
bcba001       varchar2(10)      ,/* 编码规则编号 */
bcba002       varchar2(10)      ,/* 条码类型 */
bcba003       number(20,6)      ,/* 預設包装数量 */
bcba004       varchar2(10)      ,/* 生成批号 */
bcbastus       varchar2(10)      ,/* 状态码 */
bcbaownid       varchar2(20)      ,/* 资料所有者 */
bcbaowndp       varchar2(10)      ,/* 资料所有部门 */
bcbacrtid       varchar2(20)      ,/* 资料录入者 */
bcbacrtdp       varchar2(10)      ,/* 资料录入部门 */
bcbacrtdt       timestamp(0)      ,/* 资料创建日 */
bcbamodid       varchar2(20)      ,/* 资料更改者 */
bcbamoddt       timestamp(0)      ,/* 最近更改日 */
bcbacnfid       varchar2(20)      ,/* 资料审核者 */
bcbacnfdt       timestamp(0)      ,/* 数据审核日 */
bcbaud001       varchar2(40)      ,/* 自定义字段(文本)001 */
bcbaud002       varchar2(40)      ,/* 自定义字段(文本)002 */
bcbaud003       varchar2(40)      ,/* 自定义字段(文本)003 */
bcbaud004       varchar2(40)      ,/* 自定义字段(文本)004 */
bcbaud005       varchar2(40)      ,/* 自定义字段(文本)005 */
bcbaud006       varchar2(40)      ,/* 自定义字段(文本)006 */
bcbaud007       varchar2(40)      ,/* 自定义字段(文本)007 */
bcbaud008       varchar2(40)      ,/* 自定义字段(文本)008 */
bcbaud009       varchar2(40)      ,/* 自定义字段(文本)009 */
bcbaud010       varchar2(40)      ,/* 自定义字段(文本)010 */
bcbaud011       number(20,6)      ,/* 自定义字段(数字)011 */
bcbaud012       number(20,6)      ,/* 自定义字段(数字)012 */
bcbaud013       number(20,6)      ,/* 自定义字段(数字)013 */
bcbaud014       number(20,6)      ,/* 自定义字段(数字)014 */
bcbaud015       number(20,6)      ,/* 自定义字段(数字)015 */
bcbaud016       number(20,6)      ,/* 自定义字段(数字)016 */
bcbaud017       number(20,6)      ,/* 自定义字段(数字)017 */
bcbaud018       number(20,6)      ,/* 自定义字段(数字)018 */
bcbaud019       number(20,6)      ,/* 自定义字段(数字)019 */
bcbaud020       number(20,6)      ,/* 自定义字段(数字)020 */
bcbaud021       timestamp(0)      ,/* 自定义字段(日期时间)021 */
bcbaud022       timestamp(0)      ,/* 自定义字段(日期时间)022 */
bcbaud023       timestamp(0)      ,/* 自定义字段(日期时间)023 */
bcbaud024       timestamp(0)      ,/* 自定义字段(日期时间)024 */
bcbaud025       timestamp(0)      ,/* 自定义字段(日期时间)025 */
bcbaud026       timestamp(0)      ,/* 自定义字段(日期时间)026 */
bcbaud027       timestamp(0)      ,/* 自定义字段(日期时间)027 */
bcbaud028       timestamp(0)      ,/* 自定义字段(日期时间)028 */
bcbaud029       timestamp(0)      ,/* 自定义字段(日期时间)029 */
bcbaud030       timestamp(0)      /* 自定义字段(日期时间)030 */
);
alter table bcba_t add constraint bcba_pk primary key (bcbaent,bcba001) enable validate;

create unique index bcba_pk on bcba_t (bcbaent,bcba001);

grant select on bcba_t to tiptop;
grant update on bcba_t to tiptop;
grant delete on bcba_t to tiptop;
grant insert on bcba_t to tiptop;

exit;
