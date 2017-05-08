/* 
================================================================================
檔案代號:srac_t
檔案名稱:重复性生产计划工艺档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table srac_t
(
sracent       number(5)      ,/* 企业编号 */
sracsite       varchar2(10)      ,/* 营运据点 */
srac001       varchar2(10)      ,/* 生产计划 */
srac002       varchar2(10)      ,/* 工艺编号 */
srac004       varchar2(40)      ,/* 料件编号 */
srac005       varchar2(30)      ,/* BOM特性 */
srac006       varchar2(256)      ,/* 产品特征 */
srac007       number(10,0)      ,/* 项次 */
srac008       varchar2(10)      ,/* 本站作业编号 */
srac009       varchar2(10)      ,/* 作业序 */
srac010       varchar2(10)      ,/* 群组性质 */
srac011       varchar2(10)      ,/* 群组 */
srac012       varchar2(10)      ,/* 上站作业 */
srac013       varchar2(10)      ,/* 上站制进程 */
srac014       varchar2(10)      ,/* 下站作业 */
srac015       varchar2(10)      ,/* 下站制进程 */
srac016       varchar2(10)      ,/* 工作站 */
srac017       number(15,3)      ,/* 固定工时 */
srac018       number(15,3)      ,/* 标准工时 */
srac019       number(15,3)      ,/* 固定机时 */
srac020       number(15,3)      ,/* 标准机时 */
srac021       varchar2(1)      ,/* Move in */
srac022       varchar2(1)      ,/* Check in */
srac023       varchar2(1)      ,/* 报工站 */
srac024       varchar2(1)      ,/* PQC */
srac025       varchar2(1)      ,/* Check out */
srac026       varchar2(1)      ,/* Move out */
srac027       varchar2(10)      ,/* 转出单位 */
srac028       number(20,6)      ,/* 转出单位转换率分子 */
srac029       number(20,6)      ,/* 转出单位转换率分母 */
srac030       number(20,6)      ,/* 待Movie in 数 */
srac031       number(20,6)      ,/* 待Check in数 */
srac032       number(20,6)      ,/* 在制数 */
srac033       number(20,6)      ,/* 待PQC数 */
srac034       number(20,6)      ,/* 待Check out数 */
srac035       number(20,6)      ,/* 待Move out数 */
srac036       varchar2(1)      ,/* 委外 */
srac037       varchar2(10)      ,/* 委外供应商 */
srac038       number(20,6)      ,/* 良品转入 */
srac039       number(20,6)      ,/* 返工转入 */
srac040       number(20,6)      ,/* 良品转出 */
srac041       number(20,6)      ,/* 返工转出 */
srac042       number(20,6)      ,/* 当站报废 */
srac043       number(20,6)      ,/* 当站下线 */
srac044       number(20,6)      ,/* 委外数量 */
srac045       number(20,6)      ,/* 委外完工数量 */
srac046       varchar2(10)      ,/* 转入单位 */
srac047       number(20,6)      ,/* 转入单位转换率分子 */
srac048       number(20,6)      ,/* 转入单位转换率分母 */
sracud001       varchar2(40)      ,/* 自定义栏位(文本)001 */
sracud002       varchar2(40)      ,/* 自定义栏位(文本)002 */
sracud003       varchar2(40)      ,/* 自定义栏位(文本)003 */
sracud004       varchar2(40)      ,/* 自定义栏位(文本)004 */
sracud005       varchar2(40)      ,/* 自定义栏位(文本)005 */
sracud006       varchar2(40)      ,/* 自定义栏位(文本)006 */
sracud007       varchar2(40)      ,/* 自定义栏位(文本)007 */
sracud008       varchar2(40)      ,/* 自定义栏位(文本)008 */
sracud009       varchar2(40)      ,/* 自定义栏位(文本)009 */
sracud010       varchar2(40)      ,/* 自定义栏位(文本)010 */
sracud011       number(20,6)      ,/* 自定义栏位(数字)011 */
sracud012       number(20,6)      ,/* 自定义栏位(数字)012 */
sracud013       number(20,6)      ,/* 自定义栏位(数字)013 */
sracud014       number(20,6)      ,/* 自定义栏位(数字)014 */
sracud015       number(20,6)      ,/* 自定义栏位(数字)015 */
sracud016       number(20,6)      ,/* 自定义栏位(数字)016 */
sracud017       number(20,6)      ,/* 自定义栏位(数字)017 */
sracud018       number(20,6)      ,/* 自定义栏位(数字)018 */
sracud019       number(20,6)      ,/* 自定义栏位(数字)019 */
sracud020       number(20,6)      ,/* 自定义栏位(数字)020 */
sracud021       timestamp(0)      ,/* 自定义栏位(日期时间)021 */
sracud022       timestamp(0)      ,/* 自定义栏位(日期时间)022 */
sracud023       timestamp(0)      ,/* 自定义栏位(日期时间)023 */
sracud024       timestamp(0)      ,/* 自定义栏位(日期时间)024 */
sracud025       timestamp(0)      ,/* 自定义栏位(日期时间)025 */
sracud026       timestamp(0)      ,/* 自定义栏位(日期时间)026 */
sracud027       timestamp(0)      ,/* 自定义栏位(日期时间)027 */
sracud028       timestamp(0)      ,/* 自定义栏位(日期时间)028 */
sracud029       timestamp(0)      ,/* 自定义栏位(日期时间)029 */
sracud030       timestamp(0)      /* 自定义栏位(日期时间)030 */
);
alter table srac_t add constraint srac_pk primary key (sracent,sracsite,srac001,srac002,srac004,srac005,srac006,srac007) enable validate;

create unique index srac_pk on srac_t (sracent,sracsite,srac001,srac002,srac004,srac005,srac006,srac007);

grant select on srac_t to tiptop;
grant update on srac_t to tiptop;
grant delete on srac_t to tiptop;
grant insert on srac_t to tiptop;

exit;
