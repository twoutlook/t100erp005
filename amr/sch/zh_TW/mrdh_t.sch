/* 
================================================================================
檔案代號:mrdh_t
檔案名稱:资源维修加工单单头档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table mrdh_t
(
mrdhent       number(5)      ,/* 企业编号 */
mrdhsite       varchar2(10)      ,/* 营运据点 */
mrdhdocno       varchar2(20)      ,/* 维修工单单号 */
mrdhdocdt       date      ,/* 维修日期 */
mrdh001       varchar2(20)      ,/* 维修人员 */
mrdh002       varchar2(10)      ,/* 维修部门 */
mrdh003       varchar2(20)      ,/* 资源编号 */
mrdh004       varchar2(20)      ,/* 原厂序号 */
mrdh005       number(20,6)      ,/* 维修数量 */
mrdh006       date      ,/* 预估除役日期 */
mrdh007       number(10,0)      ,/* 预计增加资源使用次数 */
mrdh008       varchar2(4000)      ,/* 备注 */
mrdhownid       varchar2(20)      ,/* 资料所有者 */
mrdhowndp       varchar2(10)      ,/* 资料所有部门 */
mrdhcrtid       varchar2(20)      ,/* 资料录入者 */
mrdhcrtdp       varchar2(10)      ,/* 资料录入部门 */
mrdhcrtdt       timestamp(0)      ,/* 资料创建日 */
mrdhmodid       varchar2(20)      ,/* 资料更改者 */
mrdhmoddt       timestamp(0)      ,/* 最近更改日 */
mrdhcnfid       varchar2(20)      ,/* 资料审核者 */
mrdhcnfdt       timestamp(0)      ,/* 数据审核日 */
mrdhpstid       varchar2(20)      ,/* 资料过账者 */
mrdhpstdt       timestamp(0)      ,/* 资料过账日 */
mrdhstus       varchar2(10)      ,/* 状态码 */
mrdhud001       varchar2(40)      ,/* 车间期望完成日 */
mrdhud002       varchar2(40)      ,/* 模具预计完成日 */
mrdhud003       varchar2(40)      ,/* 自定义字段(文本)003 */
mrdhud004       varchar2(40)      ,/* 自定义字段(文本)004 */
mrdhud005       varchar2(40)      ,/* 自定义字段(文本)005 */
mrdhud006       varchar2(40)      ,/* 自定义字段(文本)006 */
mrdhud007       varchar2(40)      ,/* 自定义字段(文本)007 */
mrdhud008       varchar2(40)      ,/* 自定义字段(文本)008 */
mrdhud009       varchar2(40)      ,/* 自定义字段(文本)009 */
mrdhud010       varchar2(40)      ,/* 自定义字段(文本)010 */
mrdhud011       number(20,6)      ,/* 自定义字段(数字)011 */
mrdhud012       number(20,6)      ,/* 自定义字段(数字)012 */
mrdhud013       number(20,6)      ,/* 自定义字段(数字)013 */
mrdhud014       number(20,6)      ,/* 自定义字段(数字)014 */
mrdhud015       number(20,6)      ,/* 自定义字段(数字)015 */
mrdhud016       number(20,6)      ,/* 自定义字段(数字)016 */
mrdhud017       number(20,6)      ,/* 自定义字段(数字)017 */
mrdhud018       number(20,6)      ,/* 自定义字段(数字)018 */
mrdhud019       number(20,6)      ,/* 自定义字段(数字)019 */
mrdhud020       number(20,6)      ,/* 自定义字段(数字)020 */
mrdhud021       timestamp(0)      ,/* 自定义字段(日期时间)021 */
mrdhud022       timestamp(0)      ,/* 自定义字段(日期时间)022 */
mrdhud023       timestamp(0)      ,/* 自定义字段(日期时间)023 */
mrdhud024       timestamp(0)      ,/* 自定义字段(日期时间)024 */
mrdhud025       timestamp(0)      ,/* 自定义字段(日期时间)025 */
mrdhud026       timestamp(0)      ,/* 自定义字段(日期时间)026 */
mrdhud027       timestamp(0)      ,/* 自定义字段(日期时间)027 */
mrdhud028       timestamp(0)      ,/* 自定义字段(日期时间)028 */
mrdhud029       timestamp(0)      ,/* 自定义字段(日期时间)029 */
mrdhud030       timestamp(0)      /* 自定义字段(日期时间)030 */
);
alter table mrdh_t add constraint mrdh_pk primary key (mrdhent,mrdhdocno) enable validate;

create unique index mrdh_pk on mrdh_t (mrdhent,mrdhdocno);

grant select on mrdh_t to tiptop;
grant update on mrdh_t to tiptop;
grant delete on mrdh_t to tiptop;
grant insert on mrdh_t to tiptop;

exit;
