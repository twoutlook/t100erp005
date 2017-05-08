/* 
================================================================================
檔案代號:dzlm_t
檔案名稱: 
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table dzlm_t
(
dzlmstus       varchar2(10)      ,/* 状态码 */
dzlm001       varchar2(10)      ,/* 建构类型 */
dzlm002       varchar2(20)      ,/* 建构代号 */
dzlm003       varchar2(255)      ,/* 建构名称 */
dzlm004       varchar2(10)      ,/* 模块 */
dzlm005       varchar2(10)      ,/* 建构版本 */
dzlm006       varchar2(10)      ,/* SD版本 */
dzlm007       varchar2(20)      ,/* SD帐号 */
dzlm008       varchar2(1)      ,/* SD权限 */
dzlm009       varchar2(10)      ,/* PR版本 */
dzlm010       varchar2(20)      ,/* PR帐号 */
dzlm011       varchar2(1)      ,/* PR权限 */
dzlmownid       varchar2(10)      ,/* 资料所有者 */
dzlmowndp       varchar2(10)      ,/* 资料所有部门 */
dzlmcrtid       varchar2(10)      ,/* 资料建立者 */
dzlmcrtdp       varchar2(10)      ,/* 资料建立部门 */
dzlmcrtdt       date      ,/* 资料创建日 */
dzlmmodid       varchar2(10)      ,/* 资料修改者 */
dzlmmoddt       date      ,/* 最近修改日 */
dzlmcnfid       varchar2(10)      ,/* 资料确认者 */
dzlmcnfdt       date      ,/* 数据确认日 */
dzlm012       varchar2(10)      /* 状态 */
);
alter table dzlm_t add constraint dzlm_pk primary key (dzlm001,dzlm002,dzlm005) enable validate;


grant select on dzlm_t to tiptop;
grant update on dzlm_t to tiptop;
grant delete on dzlm_t to tiptop;
grant insert on dzlm_t to tiptop;

exit;
