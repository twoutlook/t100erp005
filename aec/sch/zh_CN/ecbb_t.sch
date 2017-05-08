/* 
================================================================================
檔案代號:ecbb_t
檔案名稱:料件工艺单身档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table ecbb_t
(
ecbbent       number(5)      ,/* 企业编号 */
ecbbsite       varchar2(10)      ,/* 营运据点 */
ecbb001       varchar2(40)      ,/* 工艺料号 */
ecbb002       varchar2(10)      ,/* 工艺编号 */
ecbb003       number(10,0)      ,/* 项次 */
ecbb004       varchar2(10)      ,/* 本站作业 */
ecbb005       varchar2(10)      ,/* 作业序 */
ecbb006       varchar2(1)      ,/* 群组性质 */
ecbb007       varchar2(10)      ,/* 群组 */
ecbb008       varchar2(10)      ,/* 上站作业 */
ecbb009       varchar2(10)      ,/* 上站作业序 */
ecbb010       varchar2(10)      ,/* 下站作业 */
ecbb011       varchar2(10)      ,/* 下站作业序 */
ecbb012       varchar2(10)      ,/* 工作站 */
ecbb013       varchar2(1)      ,/* 允许委外 */
ecbb014       varchar2(10)      ,/* 主要加工厂 */
ecbb015       varchar2(1)      ,/* Move in */
ecbb016       varchar2(1)      ,/* Check in */
ecbb017       varchar2(1)      ,/* 报工站 */
ecbb018       varchar2(1)      ,/* PQC */
ecbb019       varchar2(1)      ,/* Check out */
ecbb020       varchar2(1)      ,/* Move out */
ecbb021       varchar2(10)      ,/* 转出单位 */
ecbb022       number(20,6)      ,/* 转出单位转换率分子 */
ecbb023       number(20,6)      ,/* 转出单位转换率分母 */
ecbb024       number(15,3)      ,/* 固定工时(分) */
ecbb025       number(15,3)      ,/* 标准工时(分) */
ecbb026       number(15,3)      ,/* 固定机时(分) */
ecbb027       number(15,3)      ,/* 标准机时(分) */
ecbb028       number(20,6)      ,/* 完成度 */
ecbb029       number(20,6)      ,/* 标准单价 */
ecbb030       varchar2(10)      ,/* 转入单位 */
ecbb031       number(20,6)      ,/* 转入单位转换分子 */
ecbb032       number(20,6)      ,/* 转入单位转换分母 */
ecbb033       varchar2(1)      ,/* 回收站 */
ecbb034       number(15,3)      ,/* 后置时间 */
ecbb035       number(5,0)      ,/* X轴 */
ecbb036       number(5,0)      ,/* Y轴 */
ecbb037       varchar2(10)      ,/* 资源群组 */
ecbbud001       varchar2(40)      ,/* 自定义字段(文本)001 */
ecbbud002       varchar2(40)      ,/* 自定义字段(文本)002 */
ecbbud003       varchar2(40)      ,/* 自定义字段(文本)003 */
ecbbud004       varchar2(40)      ,/* 自定义字段(文本)004 */
ecbbud005       varchar2(40)      ,/* 自定义字段(文本)005 */
ecbbud006       varchar2(40)      ,/* 自定义字段(文本)006 */
ecbbud007       varchar2(40)      ,/* 自定义字段(文本)007 */
ecbbud008       varchar2(40)      ,/* 自定义字段(文本)008 */
ecbbud009       varchar2(40)      ,/* 自定义字段(文本)009 */
ecbbud010       varchar2(40)      ,/* 自定义字段(文本)010 */
ecbbud011       number(20,6)      ,/* 自定义字段(数字)011 */
ecbbud012       number(20,6)      ,/* 自定义字段(数字)012 */
ecbbud013       number(20,6)      ,/* 自定义字段(数字)013 */
ecbbud014       number(20,6)      ,/* 自定义字段(数字)014 */
ecbbud015       number(20,6)      ,/* 自定义字段(数字)015 */
ecbbud016       number(20,6)      ,/* 自定义字段(数字)016 */
ecbbud017       number(20,6)      ,/* 自定义字段(数字)017 */
ecbbud018       number(20,6)      ,/* 自定义字段(数字)018 */
ecbbud019       number(20,6)      ,/* 自定义字段(数字)019 */
ecbbud020       number(20,6)      ,/* 自定义字段(数字)020 */
ecbbud021       timestamp(0)      ,/* 自定义字段(日期时间)021 */
ecbbud022       timestamp(0)      ,/* 自定义字段(日期时间)022 */
ecbbud023       timestamp(0)      ,/* 自定义字段(日期时间)023 */
ecbbud024       timestamp(0)      ,/* 自定义字段(日期时间)024 */
ecbbud025       timestamp(0)      ,/* 自定义字段(日期时间)025 */
ecbbud026       timestamp(0)      ,/* 自定义字段(日期时间)026 */
ecbbud027       timestamp(0)      ,/* 自定义字段(日期时间)027 */
ecbbud028       timestamp(0)      ,/* 自定义字段(日期时间)028 */
ecbbud029       timestamp(0)      ,/* 自定义字段(日期时间)029 */
ecbbud030       timestamp(0)      ,/* 自定义字段(日期时间)030 */
ecbb038       varchar2(10)      /* 工具群组 */
);
alter table ecbb_t add constraint ecbb_pk primary key (ecbbent,ecbbsite,ecbb001,ecbb002,ecbb003) enable validate;

create unique index ecbb_pk on ecbb_t (ecbbent,ecbbsite,ecbb001,ecbb002,ecbb003);

grant select on ecbb_t to tiptop;
grant update on ecbb_t to tiptop;
grant delete on ecbb_t to tiptop;
grant insert on ecbb_t to tiptop;

exit;
