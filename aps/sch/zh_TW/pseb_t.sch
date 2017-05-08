/* 
================================================================================
檔案代號:pseb_t
檔案名稱:APS需求單據供給法則檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:H
多語系檔案:N
============.========================.==========================================
 */
create table pseb_t
(
psebent       number(5)      ,/* 企業編號 */
psebsite       varchar2(10)      ,/* 營運據點 */
pseb001       varchar2(10)      ,/* APS版本 */
pseb002       varchar2(20)      ,/* 執行日期時間 */
pseb003       varchar2(20)      ,/* 單據編號 */
pseb004       number(10,0)      ,/* 項次 */
pseb005       number(10,0)      ,/* 項序 */
pseb006       number(10,0)      ,/* 分批序 */
pseb007       varchar2(10)      /* 供給法則編號 */
);
alter table pseb_t add constraint pseb_pk primary key (psebent,psebsite,pseb001,pseb002,pseb003,pseb004,pseb005,pseb006) enable validate;

create unique index pseb_pk on pseb_t (psebent,psebsite,pseb001,pseb002,pseb003,pseb004,pseb005,pseb006);

grant select on pseb_t to tiptop;
grant update on pseb_t to tiptop;
grant delete on pseb_t to tiptop;
grant insert on pseb_t to tiptop;

exit;
