/* 
================================================================================
檔案代號:rtar_t
檔案名稱:资源协议水电费设置档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table rtar_t
(
rtarent       number(5)      ,/* 企业编号 */
rtarunit       varchar2(10)      ,/* 应用组织 */
rtarsite       varchar2(10)      ,/* 营运据点 */
rtarseq       number(10,0)      ,/* 项次 */
rtarseq1       number(10,0)      ,/* 资源项次 */
rtar001       varchar2(20)      ,/* 资源协议编号 */
rtar002       varchar2(10)      ,/* 资源编号 */
rtar003       varchar2(10)      ,/* 费用编号 */
rtar004       varchar2(10)      ,/* 费用类型 */
rtar005       varchar2(10)      ,/* 价款类型 */
rtar006       varchar2(1)      ,/* 纳入结算单否 */
rtar007       varchar2(1)      ,/* 票扣否 */
rtar008       number(20,6)      ,/* 单价 */
rtar009       number(20,6)      ,/* 优惠度数 */
rtar010       number(20,6)      ,/* 优惠金额 */
rtaracti       varchar2(1)      /* 数据有效码 */
);
alter table rtar_t add constraint rtar_pk primary key (rtarent,rtarseq,rtarseq1,rtar001) enable validate;

create unique index rtar_pk on rtar_t (rtarent,rtarseq,rtarseq1,rtar001);

grant select on rtar_t to tiptop;
grant update on rtar_t to tiptop;
grant delete on rtar_t to tiptop;
grant insert on rtar_t to tiptop;

exit;
