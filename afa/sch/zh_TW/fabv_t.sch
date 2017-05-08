/* 
================================================================================
檔案代號:fabv_t
檔案名稱:资产调拨单身档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table fabv_t
(
fabvent       number(5)      ,/* 企业编码 */
fabvdocno       varchar2(20)      ,/* 异动单号 */
fabvseq       number(10,0)      ,/* 项次 */
fabv001       varchar2(20)      ,/* 来源单号 */
fabv002       number(10,0)      ,/* 来源项次 */
fabv003       varchar2(20)      ,/* 财产编号 */
fabv004       varchar2(20)      ,/* 附号 */
fabv005       varchar2(10)      ,/* 卡片编号 */
fabv006       varchar2(255)      ,/* 名称 */
fabv007       varchar2(255)      ,/* 规格 */
fabv008       varchar2(10)      ,/* 主要类型 */
fabv009       varchar2(10)      ,/* 存放位置 */
fabv010       number(20,6)      ,/* 调拨数量 */
fabv011       number(20,6)      ,/* 调拨成本 */
fabv012       number(20,6)      ,/* 调拨累折 */
fabv013       number(20,6)      ,/* 调拨减值准备 */
fabv014       number(20,6)      ,/* 调拨预留残值 */
fabv015       number(20,6)      ,/* 调拨价格差异 */
fabv016       varchar2(10)      ,/* 币种 */
fabv017       number(20,6)      ,/* 本位币二成本 */
fabv018       number(20,6)      ,/* 本位币二累折 */
fabv019       number(20,6)      ,/* 本位币二减值准备 */
fabv020       number(20,6)      ,/* 本位币二预留残值 */
fabvud001       varchar2(40)      ,/* 自定义字段(文本)001 */
fabvud002       varchar2(40)      ,/* 自定义字段(文本)002 */
fabvud003       varchar2(40)      ,/* 自定义字段(文本)003 */
fabvud004       varchar2(40)      ,/* 自定义字段(文本)004 */
fabvud005       varchar2(40)      ,/* 自定义字段(文本)005 */
fabvud006       varchar2(40)      ,/* 自定义字段(文本)006 */
fabvud007       varchar2(40)      ,/* 自定义字段(文本)007 */
fabvud008       varchar2(40)      ,/* 自定义字段(文本)008 */
fabvud009       varchar2(40)      ,/* 自定义字段(文本)009 */
fabvud010       varchar2(40)      ,/* 自定义字段(文本)010 */
fabvud011       number(20,6)      ,/* 自定义字段(数字)011 */
fabvud012       number(20,6)      ,/* 自定义字段(数字)012 */
fabvud013       number(20,6)      ,/* 自定义字段(数字)013 */
fabvud014       number(20,6)      ,/* 自定义字段(数字)014 */
fabvud015       number(20,6)      ,/* 自定义字段(数字)015 */
fabvud016       number(20,6)      ,/* 自定义字段(数字)016 */
fabvud017       number(20,6)      ,/* 自定义字段(数字)017 */
fabvud018       number(20,6)      ,/* 自定义字段(数字)018 */
fabvud019       number(20,6)      ,/* 自定义字段(数字)019 */
fabvud020       number(20,6)      ,/* 自定义字段(数字)020 */
fabvud021       timestamp(0)      ,/* 自定义字段(日期时间)021 */
fabvud022       timestamp(0)      ,/* 自定义字段(日期时间)022 */
fabvud023       timestamp(0)      ,/* 自定义字段(日期时间)023 */
fabvud024       timestamp(0)      ,/* 自定义字段(日期时间)024 */
fabvud025       timestamp(0)      ,/* 自定义字段(日期时间)025 */
fabvud026       timestamp(0)      ,/* 自定义字段(日期时间)026 */
fabvud027       timestamp(0)      ,/* 自定义字段(日期时间)027 */
fabvud028       timestamp(0)      ,/* 自定义字段(日期时间)028 */
fabvud029       timestamp(0)      ,/* 自定义字段(日期时间)029 */
fabvud030       timestamp(0)      ,/* 自定义字段(日期时间)030 */
fabv021       number(20,6)      ,/* 本位币二价格差异 */
fabv022       varchar2(10)      ,/* 本位币二币种 */
fabv023       number(20,10)      ,/* 本位币二汇率 */
fabv024       number(20,6)      ,/* 本位币三成本 */
fabv025       number(20,6)      ,/* 本位币三累折 */
fabv026       number(20,6)      ,/* 本位币三减值准备 */
fabv027       number(20,6)      ,/* 本位币三预留残值 */
fabv028       number(20,6)      ,/* 本位币三价格差异 */
fabv029       varchar2(10)      ,/* 本位币三币种 */
fabv030       number(20,10)      ,/* 本位币三汇率 */
fabv031       number(20,6)      /* 剩余净值 */
);
alter table fabv_t add constraint fabv_pk primary key (fabvent,fabvdocno,fabvseq) enable validate;

create unique index fabv_pk on fabv_t (fabvent,fabvdocno,fabvseq);

grant select on fabv_t to tiptop;
grant update on fabv_t to tiptop;
grant delete on fabv_t to tiptop;
grant insert on fabv_t to tiptop;

exit;
