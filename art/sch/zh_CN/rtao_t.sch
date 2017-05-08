/* 
================================================================================
檔案代號:rtao_t
檔案名稱:门店资源协议维护明细档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table rtao_t
(
rtaoent       number(5)      ,/* 企业编号 */
rtaounit       varchar2(10)      ,/* 应用组织 */
rtaosite       varchar2(10)      ,/* 所属组织 */
rtaostus       varchar2(10)      ,/* 状态码 */
rtao001       varchar2(20)      ,/* 资源协议编号 */
rtao002       number(5,0)      ,/* 版本 */
rtao003       varchar2(20)      ,/* 促销活动方案 */
rtao004       varchar2(20)      ,/* 谈判人员 */
rtao005       varchar2(10)      ,/* 谈判组织 */
rtao006       varchar2(255)      ,/* 备注 */
rtaoownid       varchar2(20)      ,/* 资料所有者 */
rtaoowndp       varchar2(10)      ,/* 资料所有部门 */
rtaocrtid       varchar2(20)      ,/* 资料录入者 */
rtaocrtdp       varchar2(10)      ,/* 资料录入部门 */
rtaocrtdt       timestamp(0)      ,/* 资料创建日 */
rtaomodid       varchar2(20)      ,/* 资料更改者 */
rtaomoddt       timestamp(0)      ,/* 最近更改日 */
rtaocnfid       varchar2(20)      ,/* 资料审核者 */
rtaocnfdt       timestamp(0)      /* 数据审核日 */
);
alter table rtao_t add constraint rtao_pk primary key (rtaoent,rtao001) enable validate;

create unique index rtao_pk on rtao_t (rtaoent,rtao001);

grant select on rtao_t to tiptop;
grant update on rtao_t to tiptop;
grant delete on rtao_t to tiptop;
grant insert on rtao_t to tiptop;

exit;
