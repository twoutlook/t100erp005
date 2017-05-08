/* 
================================================================================
檔案代號:stgj_t
檔案名稱:专柜每日收款小票明细备份档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:S
多語系檔案:N
============.========================.==========================================
 */
create table stgj_t
(
stgjent       number(5)      ,/* 企业编号 */
stgjsite       varchar2(10)      ,/* 营运组织 */
stgjunit       varchar2(10)      ,/* 应用组织 */
stgj001       varchar2(40)      ,/* 收款序号 */
stgj002       date      ,/* 销售日期 */
stgj003       varchar2(40)      ,/* 商品编号 */
stgj004       varchar2(10)      ,/* 库区编号 */
stgj005       varchar2(20)      ,/* 专柜编号 */
stgj006       varchar2(10)      ,/* 供应商编号 */
stgj007       varchar2(40)      ,/* 销售收银单号 */
stgj008       varchar2(10)      ,/* 收银大类 */
stgj009       varchar2(10)      ,/* 收银小类 */
stgj010       varchar2(1)      ,/* 收银分摊否 */
stgj011       number(20,6)      ,/* 小票实收金额 */
stgj012       number(20,6)      ,/* 小票明细实收金额 */
stgjseq       number(10,0)      /* 销售单项次 */
);
alter table stgj_t add constraint stgj_pk primary key (stgjent,stgjsite,stgj001,stgj007,stgjseq) enable validate;

create unique index stgj_pk on stgj_t (stgjent,stgjsite,stgj001,stgj007,stgjseq);

grant select on stgj_t to tiptop;
grant update on stgj_t to tiptop;
grant delete on stgj_t to tiptop;
grant insert on stgj_t to tiptop;

exit;
