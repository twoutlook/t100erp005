/* 
================================================================================
檔案代號:indc_t
檔案名稱:调拨单单头档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table indc_t
(
indcent       number(5)      ,/* 企业编号 */
indcsite       varchar2(10)      ,/* 营运据点 */
indcunit       varchar2(10)      ,/* 应用组织 */
indcdocno       varchar2(20)      ,/* 调拨单号 */
indcdocdt       date      ,/* 调拨日期 */
indc000       varchar2(10)      ,/* 单据性质 */
indc001       varchar2(20)      ,/* 对应调拨单号 */
indc002       varchar2(10)      ,/* 来源类别 */
indc003       varchar2(20)      ,/* 来源单号 */
indc004       varchar2(20)      ,/* 调拨人员 */
indc005       varchar2(10)      ,/* 拨出营运据点 */
indc006       varchar2(10)      ,/* 拨入营运据点 */
indc007       varchar2(10)      ,/* 在途仓 */
indc008       varchar2(255)      ,/* 备注 */
indc021       varchar2(20)      ,/* 拨出审核人员 */
indc022       date      ,/* 拨出审核日期 */
indc023       varchar2(20)      ,/* 拨入审核人员 */
indc024       date      ,/* 拨入审核日期 */
indcstus       varchar2(10)      ,/* 状态码 */
indcownid       varchar2(20)      ,/* 资料所有者 */
indcowndp       varchar2(10)      ,/* 资料所有部门 */
indccrtid       varchar2(20)      ,/* 资料录入者 */
indccrtdp       varchar2(10)      ,/* 资料录入部门 */
indccrtdt       timestamp(0)      ,/* 资料创建日 */
indcmodid       varchar2(20)      ,/* 资料更改者 */
indcmoddt       timestamp(0)      ,/* 最近更改日 */
indccnfid       varchar2(20)      ,/* 资料审核者 */
indccnfdt       timestamp(0)      ,/* 数据审核日 */
indcpstid       varchar2(20)      ,/* 资料过账者 */
indcpstdt       timestamp(0)      ,/* 资料过账日 */
indc101       varchar2(10)      ,/* 调拨部门 */
indc102       varchar2(10)      ,/* 检验方式 */
indc103       varchar2(1)      ,/* 包装单制作 */
indc104       varchar2(1)      ,/* Invoice制作 */
indc105       varchar2(10)      ,/* 送货地址 */
indc106       varchar2(10)      ,/* 运输方式 */
indc107       varchar2(10)      ,/* 起运地点 */
indc108       varchar2(10)      ,/* 到达地点 */
indc109       varchar2(10)      ,/* 在途非成本库位 */
indc151       varchar2(10)      ,/* 调拨理由 */
indcud001       varchar2(40)      ,/* 自定义字段(文本)001 */
indcud002       varchar2(40)      ,/* 自定义字段(文本)002 */
indcud003       varchar2(40)      ,/* 自定义字段(文本)003 */
indcud004       varchar2(40)      ,/* 自定义字段(文本)004 */
indcud005       varchar2(40)      ,/* 自定义字段(文本)005 */
indcud006       varchar2(40)      ,/* 自定义字段(文本)006 */
indcud007       varchar2(40)      ,/* 自定义字段(文本)007 */
indcud008       varchar2(40)      ,/* 自定义字段(文本)008 */
indcud009       varchar2(40)      ,/* 自定义字段(文本)009 */
indcud010       varchar2(40)      ,/* 自定义字段(文本)010 */
indcud011       number(20,6)      ,/* 自定义字段(数字)011 */
indcud012       number(20,6)      ,/* 自定义字段(数字)012 */
indcud013       number(20,6)      ,/* 自定义字段(数字)013 */
indcud014       number(20,6)      ,/* 自定义字段(数字)014 */
indcud015       number(20,6)      ,/* 自定义字段(数字)015 */
indcud016       number(20,6)      ,/* 自定义字段(数字)016 */
indcud017       number(20,6)      ,/* 自定义字段(数字)017 */
indcud018       number(20,6)      ,/* 自定义字段(数字)018 */
indcud019       number(20,6)      ,/* 自定义字段(数字)019 */
indcud020       number(20,6)      ,/* 自定义字段(数字)020 */
indcud021       timestamp(0)      ,/* 自定义字段(日期时间)021 */
indcud022       timestamp(0)      ,/* 自定义字段(日期时间)022 */
indcud023       timestamp(0)      ,/* 自定义字段(日期时间)023 */
indcud024       timestamp(0)      ,/* 自定义字段(日期时间)024 */
indcud025       timestamp(0)      ,/* 自定义字段(日期时间)025 */
indcud026       timestamp(0)      ,/* 自定义字段(日期时间)026 */
indcud027       timestamp(0)      ,/* 自定义字段(日期时间)027 */
indcud028       timestamp(0)      ,/* 自定义字段(日期时间)028 */
indcud029       timestamp(0)      ,/* 自定义字段(日期时间)029 */
indcud030       timestamp(0)      ,/* 自定义字段(日期时间)030 */
indc199       varchar2(10)      ,/* 调拨性质 */
indc009       varchar2(1)      ,/* 单一单位库存单位变更 */
indc200       varchar2(10)      ,/* 拨出仓库 */
indc201       varchar2(10)      ,/* 拨入仓库 */
indc010       varchar2(40)      ,/* 调整单号 */
indc202       varchar2(10)      ,/* 操作类型 */
indc025       varchar2(40)      ,/* 前端单号 */
indc026       varchar2(10)      /* 前端类型 */
);
alter table indc_t add constraint indc_pk primary key (indcent,indcdocno) enable validate;

create  index indc_n01 on indc_t (indcent,indcdocno,indc000,indc005,indc199,indcstus);
create unique index indc_pk on indc_t (indcent,indcdocno);

grant select on indc_t to tiptop;
grant update on indc_t to tiptop;
grant delete on indc_t to tiptop;
grant insert on indc_t to tiptop;

exit;
