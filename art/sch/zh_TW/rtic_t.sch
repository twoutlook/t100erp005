/* 
================================================================================
檔案代號:rtic_t
檔案名稱:销售交易折扣明细档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table rtic_t
(
rticent       number(5)      ,/* 企业编号 */
rticsite       varchar2(10)      ,/* 营运据点 */
rticunit       varchar2(10)      ,/* 应用组织 */
rticdocno       varchar2(20)      ,/* 单据编号 */
rticseq       number(10,0)      ,/* 项次 */
rticseq1       number(10,0)      ,/* 折扣序 */
rtic001       varchar2(10)      ,/* 单据类型 */
rtic002       varchar2(10)      ,/* 折价方式 */
rtic003       varchar2(20)      ,/* 促销规则 */
rtic004       varchar2(10)      ,/* 活动类别 */
rtic005       varchar2(10)      ,/* 活动子类别 */
rtic006       varchar2(10)      ,/* 促销方式 */
rtic007       varchar2(10)      ,/* 入机方式 */
rtic008       number(20,6)      ,/* 参与数量 */
rtic009       number(20,6)      ,/* 参与金额 */
rtic010       number(20,6)      ,/* 赠送基数 */
rtic011       number(20,6)      ,/* 赠送幅度 */
rtic012       number(20,6)      ,/* 折扣率 */
rtic013       number(20,6)      ,/* 折让金额 */
rtic014       varchar2(10)      ,/* 赠卡券种 */
rtic015       varchar2(30)      ,/* 赠卡券号 */
rtic016       number(20,6)      ,/* 赠送面额 */
rtic017       number(20,6)      ,/* 赠送面额单位金额 */
rtic018       varchar2(10)      ,/* 接卡券种 */
rtic019       varchar2(30)      ,/* 接卡券号 */
rtic020       number(20,6)      ,/* 接收基数 */
rtic021       number(20,6)      ,/* 接收幅度 */
rtic022       number(20,6)      ,/* 接收面额 */
rtic023       number(20,6)      ,/* 接收面额单位金额 */
rtic024       number(5,0)      ,/* 接卡券折扣率 */
rtic025       varchar2(10)      ,/* 来源类型 */
rtic026       varchar2(20)      ,/* 来源单号 */
rtic027       varchar2(10)      ,/* 来源折价方式 */
rtic028       number(20,6)      ,/* 承担比例 */
rtic029       varchar2(1)      ,/* 转费用否 */
rticud001       varchar2(40)      ,/* 自定义字段(文本)001 */
rticud002       varchar2(40)      ,/* 自定义字段(文本)002 */
rticud003       varchar2(40)      ,/* 自定义字段(文本)003 */
rticud004       varchar2(40)      ,/* 自定义字段(文本)004 */
rticud005       varchar2(40)      ,/* 自定义字段(文本)005 */
rticud006       varchar2(40)      ,/* 自定义字段(文本)006 */
rticud007       varchar2(40)      ,/* 自定义字段(文本)007 */
rticud008       varchar2(40)      ,/* 自定义字段(文本)008 */
rticud009       varchar2(40)      ,/* 自定义字段(文本)009 */
rticud010       varchar2(40)      ,/* 自定义字段(文本)010 */
rticud011       number(20,6)      ,/* 自定义字段(数字)011 */
rticud012       number(20,6)      ,/* 自定义字段(数字)012 */
rticud013       number(20,6)      ,/* 自定义字段(数字)013 */
rticud014       number(20,6)      ,/* 自定义字段(数字)014 */
rticud015       number(20,6)      ,/* 自定义字段(数字)015 */
rticud016       number(20,6)      ,/* 自定义字段(数字)016 */
rticud017       number(20,6)      ,/* 自定义字段(数字)017 */
rticud018       number(20,6)      ,/* 自定义字段(数字)018 */
rticud019       number(20,6)      ,/* 自定义字段(数字)019 */
rticud020       number(20,6)      ,/* 自定义字段(数字)020 */
rticud021       timestamp(0)      ,/* 自定义字段(日期时间)021 */
rticud022       timestamp(0)      ,/* 自定义字段(日期时间)022 */
rticud023       timestamp(0)      ,/* 自定义字段(日期时间)023 */
rticud024       timestamp(0)      ,/* 自定义字段(日期时间)024 */
rticud025       timestamp(0)      ,/* 自定义字段(日期时间)025 */
rticud026       timestamp(0)      ,/* 自定义字段(日期时间)026 */
rticud027       timestamp(0)      ,/* 自定义字段(日期时间)027 */
rticud028       timestamp(0)      ,/* 自定义字段(日期时间)028 */
rticud029       timestamp(0)      ,/* 自定义字段(日期时间)029 */
rticud030       timestamp(0)      /* 自定义字段(日期时间)030 */
);
alter table rtic_t add constraint rtic_pk primary key (rticent,rticdocno,rticseq,rticseq1) enable validate;

create unique index rtic_pk on rtic_t (rticent,rticdocno,rticseq,rticseq1);

grant select on rtic_t to tiptop;
grant update on rtic_t to tiptop;
grant delete on rtic_t to tiptop;
grant insert on rtic_t to tiptop;

exit;
