/* 
================================================================================
檔案代號:psbal_t
檔案名稱:MDS計算策略檔多語言檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:L
多語系檔案:N
============.========================.==========================================
 */
create table psbal_t
(
psbalent       number(5)      ,/* 企業編號 */
psbal001       varchar2(10)      ,/* MDS編號 */
psbal002       varchar2(6)      ,/* 語言別 */
psbal003       varchar2(500)      ,/* 說明 */
psbal004       varchar2(10)      /* 助記碼 */
);
alter table psbal_t add constraint psbal_pk primary key (psbalent,psbal001,psbal002) enable validate;

create unique index psbal_pk on psbal_t (psbalent,psbal001,psbal002);

grant select on psbal_t to tiptop;
grant update on psbal_t to tiptop;
grant delete on psbal_t to tiptop;
grant insert on psbal_t to tiptop;

exit;
