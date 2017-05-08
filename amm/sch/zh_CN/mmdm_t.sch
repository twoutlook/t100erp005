/* 
================================================================================
檔案代號:mmdm_t
檔案名稱:会员晋级商品异动申请明细档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table mmdm_t
(
mmdment       number(5)      ,/* 企业编号 */
mmdmdocno       varchar2(20)      ,/* 单据编号 */
mmdmseq       number(10,0)      ,/* 项次 */
mmdm001       varchar2(10)      ,/* 方向 */
mmdm002       varchar2(10)      ,/* 属性 */
mmdm003       varchar2(40)      ,/* 属性编号 */
mmdmacti       varchar2(10)      ,/* 数据有效 */
mmdmud001       varchar2(40)      ,/* 自定义字段(文本)001 */
mmdmud002       varchar2(40)      ,/* 自定义字段(文本)002 */
mmdmud003       varchar2(40)      ,/* 自定义字段(文本)003 */
mmdmud004       varchar2(40)      ,/* 自定义字段(文本)004 */
mmdmud005       varchar2(40)      ,/* 自定义字段(文本)005 */
mmdmud006       varchar2(40)      ,/* 自定义字段(文本)006 */
mmdmud007       varchar2(40)      ,/* 自定义字段(文本)007 */
mmdmud008       varchar2(40)      ,/* 自定义字段(文本)008 */
mmdmud009       varchar2(40)      ,/* 自定义字段(文本)009 */
mmdmud010       varchar2(40)      ,/* 自定义字段(文本)010 */
mmdmud011       number(20,6)      ,/* 自定义字段(数字)011 */
mmdmud012       number(20,6)      ,/* 自定义字段(数字)012 */
mmdmud013       number(20,6)      ,/* 自定义字段(数字)013 */
mmdmud014       number(20,6)      ,/* 自定义字段(数字)014 */
mmdmud015       number(20,6)      ,/* 自定义字段(数字)015 */
mmdmud016       number(20,6)      ,/* 自定义字段(数字)016 */
mmdmud017       number(20,6)      ,/* 自定义字段(数字)017 */
mmdmud018       number(20,6)      ,/* 自定义字段(数字)018 */
mmdmud019       number(20,6)      ,/* 自定义字段(数字)019 */
mmdmud020       number(20,6)      ,/* 自定义字段(数字)020 */
mmdmud021       timestamp(0)      ,/* 自定义字段(日期时间)021 */
mmdmud022       timestamp(0)      ,/* 自定义字段(日期时间)022 */
mmdmud023       timestamp(0)      ,/* 自定义字段(日期时间)023 */
mmdmud024       timestamp(0)      ,/* 自定义字段(日期时间)024 */
mmdmud025       timestamp(0)      ,/* 自定义字段(日期时间)025 */
mmdmud026       timestamp(0)      ,/* 自定义字段(日期时间)026 */
mmdmud027       timestamp(0)      ,/* 自定义字段(日期时间)027 */
mmdmud028       timestamp(0)      ,/* 自定义字段(日期时间)028 */
mmdmud029       timestamp(0)      ,/* 自定义字段(日期时间)029 */
mmdmud030       timestamp(0)      /* 自定义字段(日期时间)030 */
);
alter table mmdm_t add constraint mmdm_pk primary key (mmdment,mmdmdocno,mmdmseq) enable validate;

create unique index mmdm_pk on mmdm_t (mmdment,mmdmdocno,mmdmseq);

grant select on mmdm_t to tiptop;
grant update on mmdm_t to tiptop;
grant delete on mmdm_t to tiptop;
grant insert on mmdm_t to tiptop;

exit;
