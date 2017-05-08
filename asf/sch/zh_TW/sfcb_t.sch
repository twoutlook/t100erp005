/* 
================================================================================
檔案代號:sfcb_t
檔案名稱:工单工艺单身档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table sfcb_t
(
sfcbent       number(5)      ,/* 企业编号 */
sfcbsite       varchar2(10)      ,/* 营运据点 */
sfcbdocno       varchar2(20)      ,/* 单号 */
sfcb001       number(10,0)      ,/* RUN CARD */
sfcb002       number(10,0)      ,/* 项次 */
sfcb003       varchar2(10)      ,/* 本站作业 */
sfcb004       varchar2(10)      ,/* 作业序 */
sfcb005       varchar2(1)      ,/* 群组性质 */
sfcb006       varchar2(10)      ,/* 群组 */
sfcb007       varchar2(10)      ,/* 上站作业 */
sfcb008       varchar2(10)      ,/* 上站作业序 */
sfcb009       varchar2(10)      ,/* 下站作业 */
sfcb010       varchar2(10)      ,/* 下站作业序 */
sfcb011       varchar2(10)      ,/* 工作站 */
sfcb012       varchar2(1)      ,/* 允许委外 */
sfcb013       varchar2(10)      ,/* 主要加工厂 */
sfcb014       varchar2(1)      ,/* Move in */
sfcb015       varchar2(1)      ,/* Check in */
sfcb016       varchar2(1)      ,/* 报工站 */
sfcb017       varchar2(1)      ,/* PQC */
sfcb018       varchar2(1)      ,/* Check out */
sfcb019       varchar2(1)      ,/* Move out */
sfcb020       varchar2(10)      ,/* 转出单位 */
sfcb021       number(20,6)      ,/* 单位转换率分子 */
sfcb022       number(20,6)      ,/* 单位转换率分母 */
sfcb023       number(15,3)      ,/* 固定工时 */
sfcb024       number(15,3)      ,/* 标准工时 */
sfcb025       number(15,3)      ,/* 固定机时 */
sfcb026       number(15,3)      ,/* 标准机时 */
sfcb027       number(20,6)      ,/* 标准产出量 */
sfcb028       number(20,6)      ,/* 良品转入 */
sfcb029       number(20,6)      ,/* 返工转入 */
sfcb030       number(20,6)      ,/* 回收转入 */
sfcb031       number(20,6)      ,/* 分割转入 */
sfcb032       number(20,6)      ,/* 合并转入 */
sfcb033       number(20,6)      ,/* 良品转出 */
sfcb034       number(20,6)      ,/* 返工转出 */
sfcb035       number(20,6)      ,/* 回收转出 */
sfcb036       number(20,6)      ,/* 当站报废 */
sfcb037       number(20,6)      ,/* 当站下线 */
sfcb038       number(20,6)      ,/* 分割转出 */
sfcb039       number(20,6)      ,/* 合并转出 */
sfcb040       number(20,6)      ,/* Bonus */
sfcb041       number(20,6)      ,/* 委外加工数 */
sfcb042       number(20,6)      ,/* 委外完工数 */
sfcb043       number(20,6)      ,/* 盘点数 */
sfcb044       date      ,/* 预计开工日 */
sfcb045       date      ,/* 预计完工日 */
sfcb046       number(20,6)      ,/* 待Move in数 */
sfcb047       number(20,6)      ,/* 待Check in数 */
sfcb048       number(20,6)      ,/* 待Check out数 */
sfcb049       number(20,6)      ,/* 待Move out数 */
sfcb050       number(20,6)      ,/* 在制数 */
sfcb051       number(20,6)      ,/* 待PQC数 */
sfcb052       varchar2(10)      ,/* 转入单位 */
sfcb053       number(20,6)      ,/* 转入单位转换率分子 */
sfcb054       number(20,6)      ,/* 转入单位转换率分母 */
sfcb055       varchar2(1)      ,/* 回收站 */
sfcbud001       varchar2(40)      ,/* 自定义栏位(文字)001 */
sfcbud002       varchar2(40)      ,/* 自定义栏位(文字)002 */
sfcbud003       varchar2(40)      ,/* 自定义栏位(文字)003 */
sfcbud004       varchar2(40)      ,/* 自定义栏位(文字)004 */
sfcbud005       varchar2(40)      ,/* 自定义栏位(文字)005 */
sfcbud006       varchar2(40)      ,/* 自定义栏位(文字)006 */
sfcbud007       varchar2(40)      ,/* 自定义栏位(文字)007 */
sfcbud008       varchar2(40)      ,/* 自定义栏位(文字)008 */
sfcbud009       varchar2(40)      ,/* 自定义栏位(文字)009 */
sfcbud010       varchar2(40)      ,/* 自定义栏位(文字)010 */
sfcbud011       number(20,6)      ,/* 自定义栏位(数字)011 */
sfcbud012       number(20,6)      ,/* 自定义栏位(数字)012 */
sfcbud013       number(20,6)      ,/* 自定义栏位(数字)013 */
sfcbud014       number(20,6)      ,/* 自定义栏位(数字)014 */
sfcbud015       number(20,6)      ,/* 自定义栏位(数字)015 */
sfcbud016       number(20,6)      ,/* 自定义栏位(数字)016 */
sfcbud017       number(20,6)      ,/* 自定义栏位(数字)017 */
sfcbud018       number(20,6)      ,/* 自定义栏位(数字)018 */
sfcbud019       number(20,6)      ,/* 自定义栏位(数字)019 */
sfcbud020       number(20,6)      ,/* 自定义栏位(数字)020 */
sfcbud021       timestamp(0)      ,/* 自定义栏位(日期时间)021 */
sfcbud022       timestamp(0)      ,/* 自定义栏位(日期时间)022 */
sfcbud023       timestamp(0)      ,/* 自定义栏位(日期时间)023 */
sfcbud024       timestamp(0)      ,/* 自定义栏位(日期时间)024 */
sfcbud025       timestamp(0)      ,/* 自定义栏位(日期时间)025 */
sfcbud026       timestamp(0)      ,/* 自定义栏位(日期时间)026 */
sfcbud027       timestamp(0)      ,/* 自定义栏位(日期时间)027 */
sfcbud028       timestamp(0)      ,/* 自定义栏位(日期时间)028 */
sfcbud029       timestamp(0)      ,/* 自定义栏位(日期时间)029 */
sfcbud030       timestamp(0)      /* 自定义栏位(日期时间)030 */
);
alter table sfcb_t add constraint sfcb_pk primary key (sfcbent,sfcbdocno,sfcb001,sfcb002) enable validate;

create unique index sfcb_pk on sfcb_t (sfcbent,sfcbdocno,sfcb001,sfcb002);

grant select on sfcb_t to tiptop;
grant update on sfcb_t to tiptop;
grant delete on sfcb_t to tiptop;
grant insert on sfcb_t to tiptop;

exit;
