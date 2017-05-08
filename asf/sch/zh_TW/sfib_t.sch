/* 
================================================================================
檔案代號:sfib_t
檔案名稱:返工转出工艺单身档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table sfib_t
(
sfibent       number(5)      ,/* 企业编号 */
sfibsite       varchar2(10)      ,/* 营运据点 */
sfibdocno       varchar2(20)      ,/* 返工转出单号 */
sfibseq       number(10,0)      ,/* 项次 */
sfib001       varchar2(10)      ,/* 本站作业 */
sfib002       varchar2(10)      ,/* 作业序 */
sfib003       varchar2(80)      ,/* 群组性质 */
sfib004       varchar2(10)      ,/* 群组 */
sfib005       varchar2(10)      ,/* 上站作业 */
sfib006       varchar2(10)      ,/* 上站作业序 */
sfib007       varchar2(10)      ,/* 下站作业 */
sfib008       varchar2(10)      ,/* 下站作业序 */
sfib009       varchar2(10)      ,/* 工作站 */
sfib010       varchar2(1)      ,/* 允许委外 */
sfib011       varchar2(10)      ,/* 主要加工厂 */
sfib012       varchar2(1)      ,/* Move In */
sfib013       varchar2(1)      ,/* Check In */
sfib014       varchar2(1)      ,/* 报工站 */
sfib015       varchar2(1)      ,/* PQC */
sfib016       varchar2(1)      ,/* Check Out */
sfib017       varchar2(1)      ,/* Move Out */
sfib018       varchar2(10)      ,/* 转出单位 */
sfib019       number(20,6)      ,/* 转出单位转换率分子 */
sfib020       number(20,6)      ,/* 转出单位转换率分母 */
sfib021       number(15,3)      ,/* 固定工时 */
sfib022       number(15,3)      ,/* 标准工时 */
sfib023       number(15,3)      ,/* 固定机时 */
sfib024       number(15,3)      ,/* 标准机时 */
sfib025       number(20,6)      ,/* 标准产出量 */
sfib026       date      ,/* 预计开工日 */
sfib027       date      ,/* 预计完工日 */
sfib028       varchar2(10)      ,/* 转入单位 */
sfib029       number(20,6)      ,/* 转入单位转换率分子 */
sfib030       number(20,6)      ,/* 转入单位转换率分母 */
sfibud001       varchar2(40)      ,/* 自定义栏位(文字)001 */
sfibud002       varchar2(40)      ,/* 自定义栏位(文字)002 */
sfibud003       varchar2(40)      ,/* 自定义栏位(文字)003 */
sfibud004       varchar2(40)      ,/* 自定义栏位(文字)004 */
sfibud005       varchar2(40)      ,/* 自定义栏位(文字)005 */
sfibud006       varchar2(40)      ,/* 自定义栏位(文字)006 */
sfibud007       varchar2(40)      ,/* 自定义栏位(文字)007 */
sfibud008       varchar2(40)      ,/* 自定义栏位(文字)008 */
sfibud009       varchar2(40)      ,/* 自定义栏位(文字)009 */
sfibud010       varchar2(40)      ,/* 自定义栏位(文字)010 */
sfibud011       number(20,6)      ,/* 自定义栏位(数字)011 */
sfibud012       number(20,6)      ,/* 自定义栏位(数字)012 */
sfibud013       number(20,6)      ,/* 自定义栏位(数字)013 */
sfibud014       number(20,6)      ,/* 自定义栏位(数字)014 */
sfibud015       number(20,6)      ,/* 自定义栏位(数字)015 */
sfibud016       number(20,6)      ,/* 自定义栏位(数字)016 */
sfibud017       number(20,6)      ,/* 自定义栏位(数字)017 */
sfibud018       number(20,6)      ,/* 自定义栏位(数字)018 */
sfibud019       number(20,6)      ,/* 自定义栏位(数字)019 */
sfibud020       number(20,6)      ,/* 自定义栏位(数字)020 */
sfibud021       timestamp(0)      ,/* 自定义栏位(日期时间)021 */
sfibud022       timestamp(0)      ,/* 自定义栏位(日期时间)022 */
sfibud023       timestamp(0)      ,/* 自定义栏位(日期时间)023 */
sfibud024       timestamp(0)      ,/* 自定义栏位(日期时间)024 */
sfibud025       timestamp(0)      ,/* 自定义栏位(日期时间)025 */
sfibud026       timestamp(0)      ,/* 自定义栏位(日期时间)026 */
sfibud027       timestamp(0)      ,/* 自定义栏位(日期时间)027 */
sfibud028       timestamp(0)      ,/* 自定义栏位(日期时间)028 */
sfibud029       timestamp(0)      ,/* 自定义栏位(日期时间)029 */
sfibud030       timestamp(0)      ,/* 自定义栏位(日期时间)030 */
sfib031       varchar2(10)      ,/* 生产计划 */
sfib032       varchar2(40)      ,/* 生产料号 */
sfib033       varchar2(30)      ,/* BOM特征 */
sfib034       varchar2(256)      /* 产品特征 */
);
alter table sfib_t add constraint sfib_pk primary key (sfibent,sfibdocno,sfibseq) enable validate;

create unique index sfib_pk on sfib_t (sfibent,sfibdocno,sfibseq);

grant select on sfib_t to tiptop;
grant update on sfib_t to tiptop;
grant delete on sfib_t to tiptop;
grant insert on sfib_t to tiptop;

exit;
