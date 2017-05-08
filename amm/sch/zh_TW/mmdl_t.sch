/* 
================================================================================
檔案代號:mmdl_t
檔案名稱:会员晋级商品异动申请单头档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table mmdl_t
(
mmdlent       number(5)      ,/* 企业编号 */
mmdlsite       varchar2(10)      ,/* 营运据点 */
mmdlunit       varchar2(10)      ,/* 应用组织 */
mmdldocno       varchar2(20)      ,/* 单据编号 */
mmdldocdt       date      ,/* 单据日期 */
mmdl001       varchar2(20)      ,/* 申请人员 */
mmdl002       varchar2(10)      ,/* 申请部门 */
mmdlstus       varchar2(10)      ,/* 状态码 */
mmdlownid       varchar2(20)      ,/* 资料所有者 */
mmdlowndp       varchar2(10)      ,/* 资料所有部门 */
mmdlcrtid       varchar2(20)      ,/* 资料录入者 */
mmdlcrtdp       varchar2(10)      ,/* 资料录入部门 */
mmdlcrtdt       timestamp(0)      ,/* 资料创建日 */
mmdlmodid       varchar2(20)      ,/* 资料更改者 */
mmdlmoddt       timestamp(0)      ,/* 最近更改日 */
mmdlcnfid       varchar2(20)      ,/* 资料审核者 */
mmdlcnfdt       timestamp(0)      ,/* 数据审核日 */
mmdlpstid       varchar2(20)      ,/* 资料过账者 */
mmdlpstdt       timestamp(0)      ,/* 资料过账日 */
mmdlud001       varchar2(40)      ,/* 自定义字段(文本)001 */
mmdlud002       varchar2(40)      ,/* 自定义字段(文本)002 */
mmdlud003       varchar2(40)      ,/* 自定义字段(文本)003 */
mmdlud004       varchar2(40)      ,/* 自定义字段(文本)004 */
mmdlud005       varchar2(40)      ,/* 自定义字段(文本)005 */
mmdlud006       varchar2(40)      ,/* 自定义字段(文本)006 */
mmdlud007       varchar2(40)      ,/* 自定义字段(文本)007 */
mmdlud008       varchar2(40)      ,/* 自定义字段(文本)008 */
mmdlud009       varchar2(40)      ,/* 自定义字段(文本)009 */
mmdlud010       varchar2(40)      ,/* 自定义字段(文本)010 */
mmdlud011       number(20,6)      ,/* 自定义字段(数字)011 */
mmdlud012       number(20,6)      ,/* 自定义字段(数字)012 */
mmdlud013       number(20,6)      ,/* 自定义字段(数字)013 */
mmdlud014       number(20,6)      ,/* 自定义字段(数字)014 */
mmdlud015       number(20,6)      ,/* 自定义字段(数字)015 */
mmdlud016       number(20,6)      ,/* 自定义字段(数字)016 */
mmdlud017       number(20,6)      ,/* 自定义字段(数字)017 */
mmdlud018       number(20,6)      ,/* 自定义字段(数字)018 */
mmdlud019       number(20,6)      ,/* 自定义字段(数字)019 */
mmdlud020       number(20,6)      ,/* 自定义字段(数字)020 */
mmdlud021       timestamp(0)      ,/* 自定义字段(日期时间)021 */
mmdlud022       timestamp(0)      ,/* 自定义字段(日期时间)022 */
mmdlud023       timestamp(0)      ,/* 自定义字段(日期时间)023 */
mmdlud024       timestamp(0)      ,/* 自定义字段(日期时间)024 */
mmdlud025       timestamp(0)      ,/* 自定义字段(日期时间)025 */
mmdlud026       timestamp(0)      ,/* 自定义字段(日期时间)026 */
mmdlud027       timestamp(0)      ,/* 自定义字段(日期时间)027 */
mmdlud028       timestamp(0)      ,/* 自定义字段(日期时间)028 */
mmdlud029       timestamp(0)      ,/* 自定义字段(日期时间)029 */
mmdlud030       timestamp(0)      /* 自定义字段(日期时间)030 */
);
alter table mmdl_t add constraint mmdl_pk primary key (mmdlent,mmdldocno) enable validate;

create unique index mmdl_pk on mmdl_t (mmdlent,mmdldocno);

grant select on mmdl_t to tiptop;
grant update on mmdl_t to tiptop;
grant delete on mmdl_t to tiptop;
grant insert on mmdl_t to tiptop;

exit;
