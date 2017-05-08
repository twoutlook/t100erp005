/* 
================================================================================
檔案代號:psoo_t
檔案名稱:工單每日產出檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:H
多語系檔案:N
============.========================.==========================================
 */
create table psoo_t
(
psooent       number(5)      ,/* 企業編號 */
psoosite       varchar2(10)      ,/* 營運據點 */
psoo001       varchar2(10)      ,/* APS版本 */
psoo002       varchar2(20)      ,/* 執行日期時間 */
psoo003       varchar2(40)      ,/* 工單編號 */
psoo004       date      ,/* 產出日 */
psoo005       number(20,6)      /* 產出數量 */
);
alter table psoo_t add constraint psoo_pk primary key (psooent,psoosite,psoo001,psoo002,psoo003,psoo004) enable validate;

create unique index psoo_pk on psoo_t (psooent,psoosite,psoo001,psoo002,psoo003,psoo004);

grant select on psoo_t to tiptop;
grant update on psoo_t to tiptop;
grant delete on psoo_t to tiptop;
grant insert on psoo_t to tiptop;

exit;
