/* 
================================================================================
檔案代號:stki_t
檔案名稱:招商租赁合同申请定义账期单身档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table stki_t
(
stkient       number(5)      ,/* 企业编号 */
stkisite       varchar2(10)      ,/* 营运组织 */
stkiunit       varchar2(10)      ,/* 制定组织 */
stkidocno       varchar2(20)      ,/* 单据编号 */
stkiseq       number(10,0)      ,/* 项次 */
stki001       varchar2(20)      ,/* 合同编号 */
stki002       varchar2(10)      ,/* 费用编号 */
stki003       varchar2(10)      ,/* 结算方式 */
stki004       number(5,0)      ,/* 岀账期 */
stki005       number(5,0)      ,/* 岀账日 */
stki006       varchar2(10)      ,/* 核算制度 */
stki007       varchar2(1)      ,/* 纳入结算单否 */
stki008       varchar2(1)      ,/* 票扣否 */
stkiud001       varchar2(40)      ,/* 自定义字段(文本)001 */
stkiud002       varchar2(40)      ,/* 自定义字段(文本)002 */
stkiud003       varchar2(40)      ,/* 自定义字段(文本)003 */
stkiud004       varchar2(40)      ,/* 自定义字段(文本)004 */
stkiud005       varchar2(40)      ,/* 自定义字段(文本)005 */
stkiud006       varchar2(40)      ,/* 自定义字段(文本)006 */
stkiud007       varchar2(40)      ,/* 自定义字段(文本)007 */
stkiud008       varchar2(40)      ,/* 自定义字段(文本)008 */
stkiud009       varchar2(40)      ,/* 自定义字段(文本)009 */
stkiud010       varchar2(40)      ,/* 自定义字段(文本)010 */
stkiud011       number(20,6)      ,/* 自定义字段(数字)011 */
stkiud012       number(20,6)      ,/* 自定义字段(数字)012 */
stkiud013       number(20,6)      ,/* 自定义字段(数字)013 */
stkiud014       number(20,6)      ,/* 自定义字段(数字)014 */
stkiud015       number(20,6)      ,/* 自定义字段(数字)015 */
stkiud016       number(20,6)      ,/* 自定义字段(数字)016 */
stkiud017       number(20,6)      ,/* 自定义字段(数字)017 */
stkiud018       number(20,6)      ,/* 自定义字段(数字)018 */
stkiud019       number(20,6)      ,/* 自定义字段(数字)019 */
stkiud020       number(20,6)      ,/* 自定义字段(数字)020 */
stkiud021       timestamp(0)      ,/* 自定义字段(日期时间)021 */
stkiud022       timestamp(0)      ,/* 自定义字段(日期时间)022 */
stkiud023       timestamp(0)      ,/* 自定义字段(日期时间)023 */
stkiud024       timestamp(0)      ,/* 自定义字段(日期时间)024 */
stkiud025       timestamp(0)      ,/* 自定义字段(日期时间)025 */
stkiud026       timestamp(0)      ,/* 自定义字段(日期时间)026 */
stkiud027       timestamp(0)      ,/* 自定义字段(日期时间)027 */
stkiud028       timestamp(0)      ,/* 自定义字段(日期时间)028 */
stkiud029       timestamp(0)      ,/* 自定义字段(日期时间)029 */
stkiud030       timestamp(0)      ,/* 自定义字段(日期时间)030 */
stki009       varchar2(1)      ,/* 类型 */
stki010       varchar2(10)      /* 税种 */
);
alter table stki_t add constraint stki_pk primary key (stkient,stkidocno,stkiseq,stki001) enable validate;

create unique index stki_pk on stki_t (stkient,stkidocno,stkiseq,stki001);

grant select on stki_t to tiptop;
grant update on stki_t to tiptop;
grant delete on stki_t to tiptop;
grant insert on stki_t to tiptop;

exit;
