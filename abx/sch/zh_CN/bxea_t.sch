/* 
================================================================================
檔案代號:bxea_t
檔案名稱:放行单头档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table bxea_t
(
bxeaent       number(5)      ,/* 企业编号 */
bxeasite       varchar2(10)      ,/* 营运据点 */
bxeadocno       varchar2(20)      ,/* 放行申请单号 */
bxeadocdt       date      ,/* 放行申请日期 */
bxea001       varchar2(10)      ,/* 放行单号 */
bxea002       varchar2(20)      ,/* 申请人员 */
bxea003       varchar2(10)      ,/* 申请部门 */
bxea004       date      ,/* 出区日期 */
bxea005       varchar2(10)      ,/* 数据源 */
bxea006       varchar2(20)      ,/* 来源单号 */
bxea007       varchar2(20)      ,/* 工单/订单单号 */
bxea008       varchar2(10)      ,/* 交易对象 */
bxea009       varchar2(20)      ,/* 核准文号 */
bxea010       varchar2(10)      ,/* 出区原因 */
bxea011       varchar2(80)      ,/* 出区其他原因说明 */
bxea012       date      ,/* 出区期限 */
bxea013       date      ,/* 应返日期 */
bxea014       date      ,/* 销案日期 */
bxea015       number(20,6)      ,/* 件数 */
bxea016       varchar2(10)      ,/* 到达地址 */
bxea017       varchar2(40)      ,/* 运输工具号码 */
bxea018       varchar2(255)      ,/* 提货人 */
bxea019       varchar2(1)      ,/* 单身仅存保税品否 */
bxea020       varchar2(255)      ,/* 备注 */
bxeaownid       varchar2(20)      ,/* 资料所有者 */
bxeaowndp       varchar2(10)      ,/* 资料所属部门 */
bxeacrtid       varchar2(20)      ,/* 资料建立者 */
bxeacrtdp       varchar2(10)      ,/* 资料建立部门 */
bxeacrtdt       timestamp(0)      ,/* 资料创建日 */
bxeamodid       varchar2(20)      ,/* 资料修改者 */
bxeamoddt       timestamp(0)      ,/* 最近修改日 */
bxeacnfid       varchar2(20)      ,/* 资料确认者 */
bxeacnfdt       timestamp(0)      ,/* 资料确认日 */
bxeastus       varchar2(10)      /* 状态码 */
);
alter table bxea_t add constraint bxea_pk primary key (bxeaent,bxeadocno) enable validate;

create unique index bxea_pk on bxea_t (bxeaent,bxeadocno);

grant select on bxea_t to tiptop;
grant update on bxea_t to tiptop;
grant delete on bxea_t to tiptop;
grant insert on bxea_t to tiptop;

exit;
