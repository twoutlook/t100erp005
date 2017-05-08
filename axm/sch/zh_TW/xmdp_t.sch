/* 
================================================================================
檔案代號:xmdp_t
檔案名稱:Invoice单身明细档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table xmdp_t
(
xmdpent       number(5)      ,/* 企业编号 */
xmdpsite       varchar2(10)      ,/* 营运据点 */
xmdpdocno       varchar2(20)      ,/* 单据编号 */
xmdpseq       number(10,0)      ,/* 项次 */
xmdp001       varchar2(20)      ,/* 来源单号 */
xmdp002       number(10,0)      ,/* 来源项次 */
xmdp003       varchar2(20)      ,/* 订单单号 */
xmdp004       number(10,0)      ,/* 订单项次 */
xmdp005       number(10,0)      ,/* 订单项序 */
xmdp006       number(10,0)      ,/* 订单分批序 */
xmdp007       varchar2(10)      ,/* 子件特性 */
xmdp008       varchar2(40)      ,/* 料件编号 */
xmdp009       varchar2(256)      ,/* 产品特征 */
xmdp010       varchar2(40)      ,/* 客户料号 */
xmdp012       varchar2(40)      ,/* 包装容器 */
xmdp013       varchar2(10)      ,/* 作业编号 */
xmdp014       varchar2(10)      ,/* 工艺序 */
xmdp015       varchar2(10)      ,/* 单位 */
xmdp016       number(20,6)      ,/* 数量 */
xmdp017       varchar2(10)      ,/* 参考单位 */
xmdp018       number(20,6)      ,/* 参考数量 */
xmdp019       varchar2(10)      ,/* 计价单位 */
xmdp020       number(20,6)      ,/* 计价数量 */
xmdp021       number(20,6)      ,/* 单价 */
xmdp022       varchar2(10)      ,/* 税种 */
xmdp023       number(5,2)      ,/* 税率 */
xmdp024       number(20,6)      ,/* 税前金额 */
xmdp025       number(20,6)      ,/* 含税金额 */
xmdp026       number(20,6)      ,/* 税额 */
xmdp040       varchar2(255)      ,/* 备注 */
xmdp041       varchar2(10)      ,/* 多角流程编号 */
xmdpud001       varchar2(40)      ,/* 自定义栏位(文字)001 */
xmdpud002       varchar2(40)      ,/* 自定义栏位(文字)002 */
xmdpud003       varchar2(40)      ,/* 自定义栏位(文字)003 */
xmdpud004       varchar2(40)      ,/* 自定义栏位(文字)004 */
xmdpud005       varchar2(40)      ,/* 自定义栏位(文字)005 */
xmdpud006       varchar2(40)      ,/* 自定义栏位(文字)006 */
xmdpud007       varchar2(40)      ,/* 自定义栏位(文字)007 */
xmdpud008       varchar2(40)      ,/* 自定义栏位(文字)008 */
xmdpud009       varchar2(40)      ,/* 自定义栏位(文字)009 */
xmdpud010       varchar2(40)      ,/* 自定义栏位(文字)010 */
xmdpud011       number(20,6)      ,/* 自定义栏位(数字)011 */
xmdpud012       number(20,6)      ,/* 自定义栏位(数字)012 */
xmdpud013       number(20,6)      ,/* 自定义栏位(数字)013 */
xmdpud014       number(20,6)      ,/* 自定义栏位(数字)014 */
xmdpud015       number(20,6)      ,/* 自定义栏位(数字)015 */
xmdpud016       number(20,6)      ,/* 自定义栏位(数字)016 */
xmdpud017       number(20,6)      ,/* 自定义栏位(数字)017 */
xmdpud018       number(20,6)      ,/* 自定义栏位(数字)018 */
xmdpud019       number(20,6)      ,/* 自定义栏位(数字)019 */
xmdpud020       number(20,6)      ,/* 自定义栏位(数字)020 */
xmdpud021       timestamp(0)      ,/* 自定义栏位(日期时间)021 */
xmdpud022       timestamp(0)      ,/* 自定义栏位(日期时间)022 */
xmdpud023       timestamp(0)      ,/* 自定义栏位(日期时间)023 */
xmdpud024       timestamp(0)      ,/* 自定义栏位(日期时间)024 */
xmdpud025       timestamp(0)      ,/* 自定义栏位(日期时间)025 */
xmdpud026       timestamp(0)      ,/* 自定义栏位(日期时间)026 */
xmdpud027       timestamp(0)      ,/* 自定义栏位(日期时间)027 */
xmdpud028       timestamp(0)      ,/* 自定义栏位(日期时间)028 */
xmdpud029       timestamp(0)      ,/* 自定义栏位(日期时间)029 */
xmdpud030       timestamp(0)      ,/* 自定义栏位(日期时间)030 */
xmdp031       number(20,6)      ,/* 单价二 */
xmdp032       number(20,6)      ,/* 未税金额二 */
xmdp033       number(20,6)      ,/* 含税金额二 */
xmdp034       number(20,6)      /* 税额二 */
);
alter table xmdp_t add constraint xmdp_pk primary key (xmdpent,xmdpdocno,xmdpseq) enable validate;

create unique index xmdp_pk on xmdp_t (xmdpent,xmdpdocno,xmdpseq);

grant select on xmdp_t to tiptop;
grant update on xmdp_t to tiptop;
grant delete on xmdp_t to tiptop;
grant insert on xmdp_t to tiptop;

exit;
