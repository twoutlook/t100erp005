/* 
================================================================================
檔案代號:bcai_t
檔案名稱:供应商送货单单头档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table bcai_t
(
bcaient       number(5)      ,/* 企业代码 */
bcaisite       varchar2(10)      ,/* 营运据点 */
bcaidocno       varchar2(20)      ,/* 单号 */
bcaidocdt       date      ,/* 单据日期 */
bcai000       varchar2(10)      ,/* 供应商编号 */
bcai001       varchar2(1)      ,/* 采购性质 */
bcai002       varchar2(255)      ,/* 收货地址 */
bcai003       varchar2(20)      ,/* 收货单号 */
bcai004       number(5,0)      ,/* 打印次数 */
bcai005       varchar2(255)      ,/* 备注 */
bcaistus       varchar2(10)      /* 状态码 */
);
alter table bcai_t add constraint bcai_pk primary key (bcaient,bcaidocno) enable validate;

create unique index bcai_pk on bcai_t (bcaient,bcaidocno);

grant select on bcai_t to tiptop;
grant update on bcai_t to tiptop;
grant delete on bcai_t to tiptop;
grant insert on bcai_t to tiptop;

exit;
