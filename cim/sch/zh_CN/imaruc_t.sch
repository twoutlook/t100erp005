/* 
================================================================================
檔案代號:imaruc_t
檔案名稱:料件批量申请主档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table imaruc_t
(
imarucent       number(5)      ,/* 企业代码 */
imaruccomp       varchar2(10)      ,/* 法人 */
imarucsite       varchar2(10)      ,/* 营运据点 */
imarucdocno       varchar2(20)      ,/* 单号 */
imarucdocdt       date      ,/* 单据日期 */
imarucownid       varchar2(20)      ,/* 资料所有者 */
imarucowndp       varchar2(10)      ,/* 资料所属部门 */
imaruccrtid       varchar2(20)      ,/* 资料建立者 */
imaruccrtdp       varchar2(10)      ,/* 资料建立部门 */
imaruccrtdt       timestamp(0)      ,/* 资料创建日 */
imarucmodid       varchar2(20)      ,/* 资料修改者 */
imarucmoddt       timestamp(0)      ,/* 最近修改日 */
imaruccnfid       varchar2(20)      ,/* 资料确认者 */
imaruccnfdt       timestamp(0)      ,/* 资料确认日 */
imarucstus       varchar2(10)      ,/* 状态码 */
imaruc001       varchar2(20)      /* 申请人 */
);
alter table imaruc_t add constraint imaruc_pk primary key (imarucent,imarucdocno) enable validate;

create unique index imaruc_pk on imaruc_t (imarucent,imarucdocno);

grant select on imaruc_t to tiptop;
grant update on imaruc_t to tiptop;
grant delete on imaruc_t to tiptop;
grant insert on imaruc_t to tiptop;

exit;
