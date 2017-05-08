/* 
================================================================================
檔案代號:sffb_t
檔案名稱:单笔工艺报工档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table sffb_t
(
sffbent       number(5)      ,/* 企业编号 */
sffbsite       varchar2(10)      ,/* 营运据点 */
sffbdocno       varchar2(20)      ,/* 报工单号 */
sffbseq       number(10,0)      ,/* 项次 */
sffbdocdt       date      ,/* 单据日期 */
sffb001       varchar2(10)      ,/* 报工类别 */
sffb002       varchar2(20)      ,/* 报工人员 */
sffb003       varchar2(10)      ,/* 部门 */
sffb004       varchar2(10)      ,/* 报工班别 */
sffb005       varchar2(20)      ,/* 工单单号 */
sffb006       number(10,0)      ,/* Run Card */
sffb007       varchar2(10)      ,/* 作业编号 */
sffb008       varchar2(10)      ,/* 工艺序 */
sffb009       varchar2(10)      ,/* 工作站 */
sffb010       varchar2(20)      ,/* 机器编号 */
sffb011       number(10,0)      ,/* 作业人数 */
sffb012       date      ,/* 完成日期 */
sffb013       varchar2(8)      ,/* 完成时间 */
sffb014       number(15,3)      ,/* 工时 */
sffb015       number(15,3)      ,/* 机时 */
sffb016       varchar2(10)      ,/* 单位 */
sffb017       number(20,6)      ,/* 良品数量 */
sffb018       number(20,6)      ,/* 报废数量 */
sffb019       number(20,6)      ,/* 当站下线数量 */
sffb020       number(20,6)      ,/* 回收数量 */
sffb021       varchar2(10)      ,/* no use */
sffb022       varchar2(10)      ,/* no use */
sffb023       varchar2(255)      ,/* 备注 */
sffb024       varchar2(10)      ,/* 报工组别 */
sffb025       varchar2(10)      ,/* 生产计划 */
sffb026       varchar2(40)      ,/* 生产料号 */
sffb027       varchar2(30)      ,/* BOM特性 */
sffb028       varchar2(256)      ,/* 产品特征 */
sffbownid       varchar2(20)      ,/* 资料所有者 */
sffbowndp       varchar2(10)      ,/* 资料所有部门 */
sffbcrtid       varchar2(20)      ,/* 资料录入者 */
sffbcrtdp       varchar2(10)      ,/* 资料录入部门 */
sffbcrtdt       timestamp(0)      ,/* 资料创建日 */
sffbmodid       varchar2(20)      ,/* 资料更改者 */
sffbmoddt       timestamp(0)      ,/* 最近更改日 */
sffbcnfid       varchar2(20)      ,/* 资料审核者 */
sffbcnfdt       timestamp(0)      ,/* 数据审核日 */
sffbstus       varchar2(10)      ,/* 状态码 */
sffbud001       varchar2(40)      ,/* 模具编号 */
sffbud002       varchar2(40)      ,/* 刀具编号 */
sffbud003       varchar2(40)      ,/* 物料批次号 */
sffbud004       varchar2(40)      ,/* 班长 */
sffbud005       varchar2(40)      ,/* 自定义字段(文本)005 */
sffbud006       varchar2(40)      ,/* 自定义字段(文本)006 */
sffbud007       varchar2(40)      ,/* 自定义字段(文本)007 */
sffbud008       varchar2(40)      ,/* 自定义字段(文本)008 */
sffbud009       varchar2(40)      ,/* 自定义字段(文本)009 */
sffbud010       varchar2(40)      ,/* 自定义字段(文本)010 */
sffbud011       number(20,6)      ,/* 自定义字段(数字)011 */
sffbud012       number(20,6)      ,/* 自定义字段(数字)012 */
sffbud013       number(20,6)      ,/* 自定义字段(数字)013 */
sffbud014       number(20,6)      ,/* 自定义字段(数字)014 */
sffbud015       number(20,6)      ,/* 自定义字段(数字)015 */
sffbud016       number(20,6)      ,/* 自定义字段(数字)016 */
sffbud017       number(20,6)      ,/* 自定义字段(数字)017 */
sffbud018       number(20,6)      ,/* 自定义字段(数字)018 */
sffbud019       number(20,6)      ,/* 自定义字段(数字)019 */
sffbud020       number(20,6)      ,/* 自定义字段(数字)020 */
sffbud021       timestamp(0)      ,/* 自定义字段(日期时间)021 */
sffbud022       timestamp(0)      ,/* 自定义字段(日期时间)022 */
sffbud023       timestamp(0)      ,/* 自定义字段(日期时间)023 */
sffbud024       timestamp(0)      ,/* 自定义字段(日期时间)024 */
sffbud025       timestamp(0)      ,/* 自定义字段(日期时间)025 */
sffbud026       timestamp(0)      ,/* 自定义字段(日期时间)026 */
sffbud027       timestamp(0)      ,/* 自定义字段(日期时间)027 */
sffbud028       timestamp(0)      ,/* 自定义字段(日期时间)028 */
sffbud029       timestamp(0)      ,/* 自定义字段(日期时间)029 */
sffbud030       timestamp(0)      ,/* 自定义字段(日期时间)030 */
sffb029       varchar2(40)      ,/* 报工料号 */
sffb030       varchar2(10)      ,/* 成本中心 */
sffb031       varchar2(20)      /* 倒扣领料单号 */
);
alter table sffb_t add constraint sffb_pk primary key (sffbent,sffbdocno,sffbseq) enable validate;

create unique index sffb_pk on sffb_t (sffbent,sffbdocno,sffbseq);

grant select on sffb_t to tiptop;
grant update on sffb_t to tiptop;
grant delete on sffb_t to tiptop;
grant insert on sffb_t to tiptop;

exit;
