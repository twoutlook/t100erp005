/* 
================================================================================
檔案代號:dzvo_t
檔案名稱:代码设计点设计表(版次归1)
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table dzvo_t
(
dzvostus       varchar2(10)      ,/* no use */
dzvo001       varchar2(20)      ,/* 代码编号 */
dzvo002       varchar2(60)      ,/* 代码设计点 */
dzvo003       varchar2(15)      ,/* 设计点版次 */
dzvo004       varchar2(1)      ,/* 使用标示 */
dzvo098       clob      ,/* 设计点内容 */
dzvo005       varchar2(40)      ,/* 客户代号 */
dzvo006       varchar2(15)      ,/* no use */
dzvoownid       varchar2(10)      ,/* 资料所有者 */
dzvoowndp       varchar2(10)      ,/* 资料所有部门 */
dzvocrtid       varchar2(10)      ,/* 资料建立者 */
dzvocrtdp       varchar2(10)      ,/* 资料建立部门 */
dzvocrtdt       date      ,/* 资料创建日 */
dzvomodid       varchar2(10)      ,/* 资料修改者 */
dzvomoddt       date      ,/* 最近修改日 */
dzvo007       varchar2(1)      /* no use */
);
alter table dzvo_t add constraint dzvo_pk primary key (dzvo001,dzvo002,dzvo003,dzvo004) enable validate;


grant select on dzvo_t to tiptop;
grant update on dzvo_t to tiptop;
grant delete on dzvo_t to tiptop;
grant insert on dzvo_t to tiptop;

exit;
