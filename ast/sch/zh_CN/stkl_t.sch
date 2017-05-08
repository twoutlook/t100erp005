/* 
================================================================================
檔案代號:stkl_t
檔案名稱:招商租赁合同申请单价收费项目单身档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table stkl_t
(
stklent       number(5)      ,/* 企业编号 */
stklsite       varchar2(10)      ,/* 营运组织 */
stklunit       varchar2(10)      ,/* 制定组织 */
stkldocno       varchar2(20)      ,/* 单据编号 */
stklseq       number(10,0)      ,/* 项次 */
stkl001       varchar2(20)      ,/* 合同编号 */
stkl002       varchar2(10)      ,/* 费用类型 */
stkl003       varchar2(10)      ,/* 费用编号 */
stkl004       varchar2(1)      ,/* 纳入结算单否 */
stkl005       varchar2(1)      ,/* 票扣否 */
stkl006       number(20,6)      ,/* 单价 */
stkl007       number(20,6)      ,/* 优惠度数 */
stkl008       number(20,6)      ,/* 优惠金额 */
stklud001       varchar2(40)      ,/* 自定义字段(文本)001 */
stklud002       varchar2(40)      ,/* 自定义字段(文本)002 */
stklud003       varchar2(40)      ,/* 自定义字段(文本)003 */
stklud004       varchar2(40)      ,/* 自定义字段(文本)004 */
stklud005       varchar2(40)      ,/* 自定义字段(文本)005 */
stklud006       varchar2(40)      ,/* 自定义字段(文本)006 */
stklud007       varchar2(40)      ,/* 自定义字段(文本)007 */
stklud008       varchar2(40)      ,/* 自定义字段(文本)008 */
stklud009       varchar2(40)      ,/* 自定义字段(文本)009 */
stklud010       varchar2(40)      ,/* 自定义字段(文本)010 */
stklud011       number(20,6)      ,/* 自定义字段(数字)011 */
stklud012       number(20,6)      ,/* 自定义字段(数字)012 */
stklud013       number(20,6)      ,/* 自定义字段(数字)013 */
stklud014       number(20,6)      ,/* 自定义字段(数字)014 */
stklud015       number(20,6)      ,/* 自定义字段(数字)015 */
stklud016       number(20,6)      ,/* 自定义字段(数字)016 */
stklud017       number(20,6)      ,/* 自定义字段(数字)017 */
stklud018       number(20,6)      ,/* 自定义字段(数字)018 */
stklud019       number(20,6)      ,/* 自定义字段(数字)019 */
stklud020       number(20,6)      ,/* 自定义字段(数字)020 */
stklud021       timestamp(0)      ,/* 自定义字段(日期时间)021 */
stklud022       timestamp(0)      ,/* 自定义字段(日期时间)022 */
stklud023       timestamp(0)      ,/* 自定义字段(日期时间)023 */
stklud024       timestamp(0)      ,/* 自定义字段(日期时间)024 */
stklud025       timestamp(0)      ,/* 自定义字段(日期时间)025 */
stklud026       timestamp(0)      ,/* 自定义字段(日期时间)026 */
stklud027       timestamp(0)      ,/* 自定义字段(日期时间)027 */
stklud028       timestamp(0)      ,/* 自定义字段(日期时间)028 */
stklud029       timestamp(0)      ,/* 自定义字段(日期时间)029 */
stklud030       timestamp(0)      /* 自定义字段(日期时间)030 */
);
alter table stkl_t add constraint stkl_pk primary key (stklent,stkldocno,stklseq,stkl001) enable validate;

create unique index stkl_pk on stkl_t (stklent,stkldocno,stklseq,stkl001);

grant select on stkl_t to tiptop;
grant update on stkl_t to tiptop;
grant delete on stkl_t to tiptop;
grant insert on stkl_t to tiptop;

exit;
