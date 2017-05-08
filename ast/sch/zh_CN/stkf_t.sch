/* 
================================================================================
檔案代號:stkf_t
檔案名稱:招商租赁合同申请费用设置档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table stkf_t
(
stkfent       number(5)      ,/* 企业编号 */
stkfsite       varchar2(10)      ,/* 营运组织 */
stkfunit       varchar2(10)      ,/* 制定组织 */
stkfdocno       varchar2(20)      ,/* 单据编号 */
stkfseq       number(10,0)      ,/* 项次 */
stkf001       varchar2(20)      ,/* 合同编号 */
stkf002       varchar2(1)      ,/* 标准否 */
stkf003       varchar2(20)      ,/* 费用方案 */
stkf004       varchar2(10)      ,/* 费用编号 */
stkf005       date      ,/* 开始日期 */
stkf006       date      ,/* 结束日期 */
stkf007       varchar2(10)      ,/* 费用计算周期 */
stkf008       number(10,0)      ,/* 周期数值 */
stkf009       varchar2(10)      ,/* 计算类型 */
stkf010       varchar2(10)      ,/* 计算基准 */
stkf011       number(20,6)      ,/* 固定/单位金额 */
stkf012       number(20,6)      ,/* 比例 */
stkf013       varchar2(10)      ,/* 保底否 */
stkf014       number(20,6)      ,/* 保底金额 */
stkf015       number(20,6)      ,/* 保底扣点 */
stkf016       varchar2(10)      ,/* 分量扣点 */
stkf017       number(20,6)      ,/* 费用总金额 */
stkfud001       varchar2(40)      ,/* 自定义字段(文本)001 */
stkfud002       varchar2(40)      ,/* 自定义字段(文本)002 */
stkfud003       varchar2(40)      ,/* 自定义字段(文本)003 */
stkfud004       varchar2(40)      ,/* 自定义字段(文本)004 */
stkfud005       varchar2(40)      ,/* 自定义字段(文本)005 */
stkfud006       varchar2(40)      ,/* 自定义字段(文本)006 */
stkfud007       varchar2(40)      ,/* 自定义字段(文本)007 */
stkfud008       varchar2(40)      ,/* 自定义字段(文本)008 */
stkfud009       varchar2(40)      ,/* 自定义字段(文本)009 */
stkfud010       varchar2(40)      ,/* 自定义字段(文本)010 */
stkfud011       number(20,6)      ,/* 自定义字段(数字)011 */
stkfud012       number(20,6)      ,/* 自定义字段(数字)012 */
stkfud013       number(20,6)      ,/* 自定义字段(数字)013 */
stkfud014       number(20,6)      ,/* 自定义字段(数字)014 */
stkfud015       number(20,6)      ,/* 自定义字段(数字)015 */
stkfud016       number(20,6)      ,/* 自定义字段(数字)016 */
stkfud017       number(20,6)      ,/* 自定义字段(数字)017 */
stkfud018       number(20,6)      ,/* 自定义字段(数字)018 */
stkfud019       number(20,6)      ,/* 自定义字段(数字)019 */
stkfud020       number(20,6)      ,/* 自定义字段(数字)020 */
stkfud021       timestamp(0)      ,/* 自定义字段(日期时间)021 */
stkfud022       timestamp(0)      ,/* 自定义字段(日期时间)022 */
stkfud023       timestamp(0)      ,/* 自定义字段(日期时间)023 */
stkfud024       timestamp(0)      ,/* 自定义字段(日期时间)024 */
stkfud025       timestamp(0)      ,/* 自定义字段(日期时间)025 */
stkfud026       timestamp(0)      ,/* 自定义字段(日期时间)026 */
stkfud027       timestamp(0)      ,/* 自定义字段(日期时间)027 */
stkfud028       timestamp(0)      ,/* 自定义字段(日期时间)028 */
stkfud029       timestamp(0)      ,/* 自定义字段(日期时间)029 */
stkfud030       timestamp(0)      ,/* 自定义字段(日期时间)030 */
stkf018       number(20,6)      ,/* 审核金额 */
stkf019       number(20,6)      ,/* 审核比例 */
stkf020       varchar2(1)      ,/* 可延用 */
stkf021       varchar2(10)      ,/* 费用方案版本 */
stkf022       varchar2(20)      ,/* 场地编号 */
stkf023       varchar2(10)      ,/* 费用归属类型 */
stkf024       varchar2(10)      ,/* 费用归属组织 */
stkf025       varchar2(10)      /* 合同版本 */
);
alter table stkf_t add constraint stkf_pk primary key (stkfent,stkfdocno,stkfseq,stkf001) enable validate;

create unique index stkf_pk on stkf_t (stkfent,stkfdocno,stkfseq,stkf001);

grant select on stkf_t to tiptop;
grant update on stkf_t to tiptop;
grant delete on stkf_t to tiptop;
grant insert on stkf_t to tiptop;

exit;
