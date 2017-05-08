/* 
================================================================================
檔案代號:xmev_t
檔案名稱:销售估价单头档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table xmev_t
(
xmevent       number(5)      ,/* 企业编号 */
xmevsite       varchar2(10)      ,/* 营运据点 */
xmevdocno       varchar2(20)      ,/* 估价单号 */
xmevdocdt       date      ,/* 估价日期 */
xmev001       varchar2(20)      ,/* 业务人员 */
xmev002       varchar2(10)      ,/* 业务部门 */
xmev003       varchar2(10)      ,/* 客户编号 */
xmev004       varchar2(20)      ,/* 范本料号 */
xmev005       varchar2(10)      ,/* 材料取价方式 */
xmev006       varchar2(10)      ,/* 币种 */
xmev007       number(20,10)      ,/* 汇率 */
xmev008       varchar2(10)      ,/* 税种 */
xmev009       number(5,2)      ,/* 税率 */
xmev010       varchar2(1)      ,/* 单价含税否 */
xmev011       number(20,6)      ,/* 估价数量 */
xmev012       varchar2(10)      ,/* 估价单位 */
xmev013       date      ,/* 估价有效期限 */
xmev014       number(20,6)      ,/* 材料金额 */
xmev015       number(20,6)      ,/* 人工金额 */
xmev016       number(20,6)      ,/* 制费金额 */
xmev017       number(20,6)      ,/* 其他费用 */
xmev018       number(20,6)      ,/* 估价金额 */
xmev019       varchar2(255)      ,/* 备注 */
xmevownid       varchar2(20)      ,/* 资料所有者 */
xmevowndp       varchar2(10)      ,/* 资料所有部门 */
xmevcrtid       varchar2(20)      ,/* 资料录入者 */
xmevcrtdp       varchar2(10)      ,/* 资料录入部门 */
xmevcrtdt       timestamp(0)      ,/* 资料创建日 */
xmevmodid       varchar2(20)      ,/* 资料更改者 */
xmevmoddt       timestamp(0)      ,/* 最近更改日 */
xmevcnfid       varchar2(20)      ,/* 资料审核者 */
xmevcnfdt       timestamp(0)      ,/* 数据审核日 */
xmevpstid       varchar2(20)      ,/* 资料过账者 */
xmevpstdt       timestamp(0)      ,/* 资料过账日 */
xmevstus       varchar2(10)      ,/* 状态码 */
xmevud001       varchar2(40)      ,/* 自定义栏位(文字)001 */
xmevud002       varchar2(40)      ,/* 自定义栏位(文字)002 */
xmevud003       varchar2(40)      ,/* 自定义栏位(文字)003 */
xmevud004       varchar2(40)      ,/* 自定义栏位(文字)004 */
xmevud005       varchar2(40)      ,/* 自定义栏位(文字)005 */
xmevud006       varchar2(40)      ,/* 自定义栏位(文字)006 */
xmevud007       varchar2(40)      ,/* 自定义栏位(文字)007 */
xmevud008       varchar2(40)      ,/* 自定义栏位(文字)008 */
xmevud009       varchar2(40)      ,/* 自定义栏位(文字)009 */
xmevud010       varchar2(40)      ,/* 自定义栏位(文字)010 */
xmevud011       number(20,6)      ,/* 自定义栏位(数字)011 */
xmevud012       number(20,6)      ,/* 自定义栏位(数字)012 */
xmevud013       number(20,6)      ,/* 自定义栏位(数字)013 */
xmevud014       number(20,6)      ,/* 自定义栏位(数字)014 */
xmevud015       number(20,6)      ,/* 自定义栏位(数字)015 */
xmevud016       number(20,6)      ,/* 自定义栏位(数字)016 */
xmevud017       number(20,6)      ,/* 自定义栏位(数字)017 */
xmevud018       number(20,6)      ,/* 自定义栏位(数字)018 */
xmevud019       number(20,6)      ,/* 自定义栏位(数字)019 */
xmevud020       number(20,6)      ,/* 自定义栏位(数字)020 */
xmevud021       timestamp(0)      ,/* 自定义栏位(日期时间)021 */
xmevud022       timestamp(0)      ,/* 自定义栏位(日期时间)022 */
xmevud023       timestamp(0)      ,/* 自定义栏位(日期时间)023 */
xmevud024       timestamp(0)      ,/* 自定义栏位(日期时间)024 */
xmevud025       timestamp(0)      ,/* 自定义栏位(日期时间)025 */
xmevud026       timestamp(0)      ,/* 自定义栏位(日期时间)026 */
xmevud027       timestamp(0)      ,/* 自定义栏位(日期时间)027 */
xmevud028       timestamp(0)      ,/* 自定义栏位(日期时间)028 */
xmevud029       timestamp(0)      ,/* 自定义栏位(日期时间)029 */
xmevud030       timestamp(0)      ,/* 自定义栏位(日期时间)030 */
xmev020       varchar2(20)      /* 一次性交易对象识别码 */
);
alter table xmev_t add constraint xmev_pk primary key (xmevent,xmevdocno) enable validate;

create unique index xmev_pk on xmev_t (xmevent,xmevdocno);

grant select on xmev_t to tiptop;
grant update on xmev_t to tiptop;
grant delete on xmev_t to tiptop;
grant insert on xmev_t to tiptop;

exit;
