/* 
================================================================================
檔案代號:psou_t
檔案名稱:工單領料需求時間檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:H
多語系檔案:N
============.========================.==========================================
 */
create table psou_t
(
psouent       number(5)      ,/* 企業編號 */
psousite       varchar2(10)      ,/* 營運據點 */
psou001       varchar2(10)      ,/* APS版本 */
psou002       varchar2(20)      ,/* 執行日期時間 */
psou003       varchar2(10)      ,/* 流水編號 */
psou004       varchar2(40)      ,/* 工單編號 */
psou005       varchar2(80)      ,/* 途程編號 */
psou006       varchar2(10)      ,/* 加工序號 */
psou007       varchar2(10)      ,/* 作業編號 */
psou008       varchar2(500)      ,/* 元件品號 */
psou009       date      ,/* 需求日期 */
psou010       varchar2(40)      ,/* 品號 */
psou011       varchar2(256)      /* 品號特徵碼 */
);
alter table psou_t add constraint psou_pk primary key (psouent,psousite,psou001,psou002,psou003) enable validate;

create unique index psou_pk on psou_t (psouent,psousite,psou001,psou002,psou003);

grant select on psou_t to tiptop;
grant update on psou_t to tiptop;
grant delete on psou_t to tiptop;
grant insert on psou_t to tiptop;

exit;
