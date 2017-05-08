/* 
================================================================================
檔案代號:psec_t
檔案名稱:低階碼計算訊息記錄檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:H
多語系檔案:N
============.========================.==========================================
 */
create table psec_t
(
psecent       number(5)      ,/* 企業編號 */
psecsite       varchar2(10)      ,/* 營運據點 */
psec001       varchar2(10)      ,/* APS版本 */
psec002       varchar2(20)      ,/* 執行日期時間 */
psec003       number(10,0)      ,/* 項次 */
psec004       varchar2(40)      ,/* 主件料號 */
psec005       varchar2(40)      ,/* 元件/聯產品/副產品/多產出料號 */
psec006       varchar2(40)      ,/* 取替代料號 */
psec007       varchar2(10)      /* 錯誤訊息碼 */
);
alter table psec_t add constraint psec_pk primary key (psecent,psecsite,psec001,psec002,psec003) enable validate;

create unique index psec_pk on psec_t (psecent,psecsite,psec001,psec002,psec003);

grant select on psec_t to tiptop;
grant update on psec_t to tiptop;
grant delete on psec_t to tiptop;
grant insert on psec_t to tiptop;

exit;
