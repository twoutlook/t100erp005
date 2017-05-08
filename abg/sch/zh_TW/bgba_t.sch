/* 
================================================================================
檔案代號:bgba_t
檔案名稱:预算凭证单头档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table bgba_t
(
bgbaent       number(5)      ,/* 企业代码 */
bgbadocno       varchar2(20)      ,/* 凭证编号 */
bgba001       varchar2(10)      ,/* 预算编号 */
bgba002       varchar2(10)      ,/* 版本 */
bgba003       varchar2(10)      ,/* 预算周期 */
bgba004       number(5,0)      ,/* 预算期别 */
bgba005       varchar2(10)      ,/* 预算组织 */
bgba006       varchar2(10)      ,/* 预算币别 */
bgba007       varchar2(10)      ,/* 資料來源 */
bgba008       number(5,0)      ,/* 打印次数 */
bgba009       varchar2(1)      ,/* 外币凭证否 */
bgba010       varchar2(10)      ,/* 管理组织 */
bgbaownid       varchar2(20)      ,/* 资料所有者 */
bgbaowndp       varchar2(10)      ,/* 资料所有部门 */
bgbacrtid       varchar2(20)      ,/* 资料录入者 */
bgbacrtdp       varchar2(10)      ,/* 资料录入部门 */
bgbacrtdt       timestamp(0)      ,/* 资料创建日 */
bgbamodid       varchar2(20)      ,/* 资料更改者 */
bgbamoddt       timestamp(0)      ,/* 最近更改日 */
bgbacnfid       varchar2(20)      ,/* 资料审核者 */
bgbacnfdt       timestamp(0)      ,/* 数据审核日 */
bgbastus       varchar2(10)      ,/* 状态码 */
bgbaud001       varchar2(40)      ,/* 自定义字段(文本)001 */
bgbaud002       varchar2(40)      ,/* 自定义字段(文本)002 */
bgbaud003       varchar2(40)      ,/* 自定义字段(文本)003 */
bgbaud004       varchar2(40)      ,/* 自定义字段(文本)004 */
bgbaud005       varchar2(40)      ,/* 自定义字段(文本)005 */
bgbaud006       varchar2(40)      ,/* 自定义字段(文本)006 */
bgbaud007       varchar2(40)      ,/* 自定义字段(文本)007 */
bgbaud008       varchar2(40)      ,/* 自定义字段(文本)008 */
bgbaud009       varchar2(40)      ,/* 自定义字段(文本)009 */
bgbaud010       varchar2(40)      ,/* 自定义字段(文本)010 */
bgbaud011       number(20,6)      ,/* 自定义字段(数字)011 */
bgbaud012       number(20,6)      ,/* 自定义字段(数字)012 */
bgbaud013       number(20,6)      ,/* 自定义字段(数字)013 */
bgbaud014       number(20,6)      ,/* 自定义字段(数字)014 */
bgbaud015       number(20,6)      ,/* 自定义字段(数字)015 */
bgbaud016       number(20,6)      ,/* 自定义字段(数字)016 */
bgbaud017       number(20,6)      ,/* 自定义字段(数字)017 */
bgbaud018       number(20,6)      ,/* 自定义字段(数字)018 */
bgbaud019       number(20,6)      ,/* 自定义字段(数字)019 */
bgbaud020       number(20,6)      ,/* 自定义字段(数字)020 */
bgbaud021       timestamp(0)      ,/* 自定义字段(日期时间)021 */
bgbaud022       timestamp(0)      ,/* 自定义字段(日期时间)022 */
bgbaud023       timestamp(0)      ,/* 自定义字段(日期时间)023 */
bgbaud024       timestamp(0)      ,/* 自定义字段(日期时间)024 */
bgbaud025       timestamp(0)      ,/* 自定义字段(日期时间)025 */
bgbaud026       timestamp(0)      ,/* 自定义字段(日期时间)026 */
bgbaud027       timestamp(0)      ,/* 自定义字段(日期时间)027 */
bgbaud028       timestamp(0)      ,/* 自定义字段(日期时间)028 */
bgbaud029       timestamp(0)      ,/* 自定义字段(日期时间)029 */
bgbaud030       timestamp(0)      /* 自定义字段(日期时间)030 */
);
alter table bgba_t add constraint bgba_pk primary key (bgbaent,bgbadocno) enable validate;

create  index bgba_n on bgba_t (bgba001,bgba002,bgba005);
create unique index bgba_pk on bgba_t (bgbaent,bgbadocno);

grant select on bgba_t to tiptop;
grant update on bgba_t to tiptop;
grant delete on bgba_t to tiptop;
grant insert on bgba_t to tiptop;

exit;
