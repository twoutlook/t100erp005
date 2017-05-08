/* 
================================================================================
檔案代號:psop_t
檔案名稱:工單製程每日產出檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:H
多語系檔案:N
============.========================.==========================================
 */
create table psop_t
(
psopent       number(5)      ,/* 企業編號 */
psopsite       varchar2(10)      ,/* 營運據點 */
psop001       varchar2(10)      ,/* APS版本 */
psop002       varchar2(20)      ,/* 執行日期時間 */
psop004       varchar2(40)      ,/* 工單編號 */
psop005       varchar2(10)      ,/* 加工序號 */
psop006       date      ,/* 產出日 */
psop007       number(5,0)      ,/* 外包 */
psop008       varchar2(20)      ,/* 資源編號 */
psop009       number(10,0)      ,/* 排程順序 */
psop010       varchar2(80)      ,/* 途程編號 */
psop011       varchar2(10)      ,/* 作業編號 */
psop012       number(20,6)      ,/* 產出數量 */
psop013       number(10,0)      ,/* 整備製造週期 */
psop014       number(10,0)      ,/* 加工製造週期 */
psop015       varchar2(10)      /* 資源群組 */
);
alter table psop_t add constraint psop_pk primary key (psopent,psopsite,psop001,psop002,psop004,psop005,psop006,psop007,psop008,psop009) enable validate;

create unique index psop_pk on psop_t (psopent,psopsite,psop001,psop002,psop004,psop005,psop006,psop007,psop008,psop009);

grant select on psop_t to tiptop;
grant update on psop_t to tiptop;
grant delete on psop_t to tiptop;
grant insert on psop_t to tiptop;

exit;
