/* 
================================================================================
檔案代號:xcfn_t
檔案名稱:LCM在制成本和市价数据档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table xcfn_t
(
xcfnent       number(5)      ,/* 企业编号 */
xcfncomp       varchar2(10)      ,/* 法人组织 */
xcfnld       varchar2(5)      ,/* 账套 */
xcfn001       varchar2(1)      ,/* 账套本位币顺序 */
xcfn002       varchar2(30)      ,/* 成本域 */
xcfn003       varchar2(10)      ,/* 成本计算类型 */
xcfn004       number(5,0)      ,/* 年度 */
xcfn005       number(5,0)      ,/* 期别 */
xcfn006       varchar2(20)      ,/* 工单编号 */
xcfn007       varchar2(40)      ,/* 料件编号 */
xcfn008       varchar2(256)      ,/* 产品特征 */
xcfn009       varchar2(30)      ,/* 批号 */
xcfn010       varchar2(10)      ,/* 单位 */
xcfn011       number(20,6)      ,/* 在制数量 */
xcfn012       number(20,6)      ,/* 在制成本单价 */
xcfn013       number(20,6)      ,/* 在制成本金额 */
xcfn014       number(20,6)      ,/* 净变现单价 */
xcfn015       number(20,6)      ,/* 净变现金额 */
xcfn016       number(20,6)      ,/* 个别项目 */
xcfn017       number(20,6)      ,/* 备抵跌价损失 */
xcfn018       number(20,6)      ,/* 备抵跌价利益 */
xcfn019       number(20,6)      ,/* 销售费用率 */
xcfn020       varchar2(40)      ,/* 逆推成品料号 */
xcfn021       number(20,6)      ,/* 逆推成品料号-净变现单价 */
xcfn022       varchar2(20)      ,/* 参考单号 */
xcfn023       number(10,0)      ,/* 参考项次 */
xcfnud001       varchar2(40)      ,/* 自定义字段(文本)001 */
xcfnud002       varchar2(40)      ,/* 自定义字段(文本)002 */
xcfnud003       varchar2(40)      ,/* 自定义字段(文本)003 */
xcfnud004       varchar2(40)      ,/* 自定义字段(文本)004 */
xcfnud005       varchar2(40)      ,/* 自定义字段(文本)005 */
xcfnud006       varchar2(40)      ,/* 自定义字段(文本)006 */
xcfnud007       varchar2(40)      ,/* 自定义字段(文本)007 */
xcfnud008       varchar2(40)      ,/* 自定义字段(文本)008 */
xcfnud009       varchar2(40)      ,/* 自定义字段(文本)009 */
xcfnud010       varchar2(40)      ,/* 自定义字段(文本)010 */
xcfnud011       number(20,6)      ,/* 自定义字段(数字)011 */
xcfnud012       number(20,6)      ,/* 自定义字段(数字)012 */
xcfnud013       number(20,6)      ,/* 自定义字段(数字)013 */
xcfnud014       number(20,6)      ,/* 自定义字段(数字)014 */
xcfnud015       number(20,6)      ,/* 自定义字段(数字)015 */
xcfnud016       number(20,6)      ,/* 自定义字段(数字)016 */
xcfnud017       number(20,6)      ,/* 自定义字段(数字)017 */
xcfnud018       number(20,6)      ,/* 自定义字段(数字)018 */
xcfnud019       number(20,6)      ,/* 自定义字段(数字)019 */
xcfnud020       number(20,6)      ,/* 自定义字段(数字)020 */
xcfnud021       timestamp(0)      ,/* 自定义字段(日期时间)021 */
xcfnud022       timestamp(0)      ,/* 自定义字段(日期时间)022 */
xcfnud023       timestamp(0)      ,/* 自定义字段(日期时间)023 */
xcfnud024       timestamp(0)      ,/* 自定义字段(日期时间)024 */
xcfnud025       timestamp(0)      ,/* 自定义字段(日期时间)025 */
xcfnud026       timestamp(0)      ,/* 自定义字段(日期时间)026 */
xcfnud027       timestamp(0)      ,/* 自定义字段(日期时间)027 */
xcfnud028       timestamp(0)      ,/* 自定义字段(日期时间)028 */
xcfnud029       timestamp(0)      ,/* 自定义字段(日期时间)029 */
xcfnud030       timestamp(0)      /* 自定义字段(日期时间)030 */
);
alter table xcfn_t add constraint xcfn_pk primary key (xcfnent,xcfnld,xcfn001,xcfn002,xcfn003,xcfn004,xcfn005,xcfn006) enable validate;

create unique index xcfn_pk on xcfn_t (xcfnent,xcfnld,xcfn001,xcfn002,xcfn003,xcfn004,xcfn005,xcfn006);

grant select on xcfn_t to tiptop;
grant update on xcfn_t to tiptop;
grant delete on xcfn_t to tiptop;
grant insert on xcfn_t to tiptop;

exit;
