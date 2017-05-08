/* 
================================================================================
檔案代號:inba_t
檔案名稱:杂项库存异动单头档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table inba_t
(
inbaent       number(5)      ,/* 企业编号 */
inbasite       varchar2(10)      ,/* 营运据点 */
inbadocno       varchar2(20)      ,/* 单据编号 */
inbadocdt       date      ,/* 录入日期 */
inba001       varchar2(10)      ,/* 单据类别 */
inba002       date      ,/* 扣账日期 */
inba003       varchar2(20)      ,/* 申请人员 */
inba004       varchar2(10)      ,/* 申请部门 */
inba005       varchar2(10)      ,/* 来源数据类型 */
inba006       varchar2(20)      ,/* 来源单号 */
inba007       varchar2(10)      ,/* 理由码 */
inba008       varchar2(255)      ,/* 备注 */
inba009       varchar2(10)      ,/* 保税异动原因 */
inba010       varchar2(20)      ,/* 保税进口报单 */
inba011       date      ,/* 保税进口报单日期 */
inbaownid       varchar2(20)      ,/* 资料所有者 */
inbaowndp       varchar2(10)      ,/* 资料所有部门 */
inbacrtid       varchar2(20)      ,/* 资料录入者 */
inbacrtdp       varchar2(10)      ,/* 资料录入部门 */
inbacrtdt       timestamp(0)      ,/* 资料创建日 */
inbamodid       varchar2(20)      ,/* 资料更改者 */
inbamoddt       timestamp(0)      ,/* 最近更改日 */
inbacnfid       varchar2(20)      ,/* 资料审核者 */
inbacnfdt       timestamp(0)      ,/* 数据审核日 */
inbapstid       varchar2(20)      ,/* 资料过账者 */
inbapstdt       timestamp(0)      ,/* 资料过账日 */
inbastus       varchar2(10)      ,/* 状态码 */
inbaud001       varchar2(40)      ,/* 自定义字段(文本)001 */
inbaud002       varchar2(40)      ,/* 自定义字段(文本)002 */
inbaud003       varchar2(40)      ,/* 自定义字段(文本)003 */
inbaud004       varchar2(40)      ,/* 自定义字段(文本)004 */
inbaud005       varchar2(40)      ,/* 自定义字段(文本)005 */
inbaud006       varchar2(40)      ,/* 自定义字段(文本)006 */
inbaud007       varchar2(40)      ,/* 自定义字段(文本)007 */
inbaud008       varchar2(40)      ,/* 自定义字段(文本)008 */
inbaud009       varchar2(40)      ,/* 自定义字段(文本)009 */
inbaud010       varchar2(40)      ,/* 自定义字段(文本)010 */
inbaud011       number(20,6)      ,/* 自定义字段(数字)011 */
inbaud012       number(20,6)      ,/* 自定义字段(数字)012 */
inbaud013       number(20,6)      ,/* 自定义字段(数字)013 */
inbaud014       number(20,6)      ,/* 自定义字段(数字)014 */
inbaud015       number(20,6)      ,/* 自定义字段(数字)015 */
inbaud016       number(20,6)      ,/* 自定义字段(数字)016 */
inbaud017       number(20,6)      ,/* 自定义字段(数字)017 */
inbaud018       number(20,6)      ,/* 自定义字段(数字)018 */
inbaud019       number(20,6)      ,/* 自定义字段(数字)019 */
inbaud020       number(20,6)      ,/* 自定义字段(数字)020 */
inbaud021       timestamp(0)      ,/* 自定义字段(日期时间)021 */
inbaud022       timestamp(0)      ,/* 自定义字段(日期时间)022 */
inbaud023       timestamp(0)      ,/* 自定义字段(日期时间)023 */
inbaud024       timestamp(0)      ,/* 自定义字段(日期时间)024 */
inbaud025       timestamp(0)      ,/* 自定义字段(日期时间)025 */
inbaud026       timestamp(0)      ,/* 自定义字段(日期时间)026 */
inbaud027       timestamp(0)      ,/* 自定义字段(日期时间)027 */
inbaud028       timestamp(0)      ,/* 自定义字段(日期时间)028 */
inbaud029       timestamp(0)      ,/* 自定义字段(日期时间)029 */
inbaud030       timestamp(0)      ,/* 自定义字段(日期时间)030 */
inbaunit       varchar2(10)      ,/* 应用组织 */
inba012       varchar2(10)      ,/* 领用类型 */
inba013       varchar2(10)      ,/* 费用对象 */
inba014       varchar2(1)      ,/* 直接交款否 */
inba015       varchar2(10)      ,/* 库位 */
inba200       varchar2(10)      ,/* 冲减方式 */
inba201       varchar2(10)      ,/* 管理品类 */
inba202       varchar2(10)      ,/* 来源作业 */
inba203       varchar2(10)      ,/* 管理品类 */
inba204       varchar2(10)      ,/* 供应商编号 */
inba205       varchar2(10)      ,/* 领用部门 */
inba206       varchar2(10)      ,/* 转入库位 */
inba207       varchar2(10)      ,/* 转入管理品类 */
inba208       varchar2(1)      /* 返回 */
);
alter table inba_t add constraint inba_pk primary key (inbaent,inbadocno) enable validate;

create unique index inba_pk on inba_t (inbaent,inbadocno);

grant select on inba_t to tiptop;
grant update on inba_t to tiptop;
grant delete on inba_t to tiptop;
grant insert on inba_t to tiptop;

exit;
