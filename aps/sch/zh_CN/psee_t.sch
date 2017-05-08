/* 
================================================================================
檔案代號:psee_t
檔案名稱:APS需求單據供給法則檔(供給類對應法則)
檔案目的: 
上游檔案:
下游檔案:
檔案類型:H
多語系檔案:N
============.========================.==========================================
 */
create table psee_t
(
pseeent       number(5)      ,/* 企業代碼 */
pseesite       varchar2(10)      ,/* 營運據點 */
psee001       varchar2(10)      ,/* APS版本 */
psee002       varchar2(20)      ,/* 執行日期時間 */
psee003       number(10,0)      ,/* 序號 */
psee004       varchar2(10)      /* 供給法則 */
);
alter table psee_t add constraint psee_pk primary key (pseeent,pseesite,psee001,psee002,psee003,psee004) enable validate;

create unique index psee_pk on psee_t (pseeent,pseesite,psee001,psee002,psee003,psee004);

grant select on psee_t to tiptop;
grant update on psee_t to tiptop;
grant delete on psee_t to tiptop;
grant insert on psee_t to tiptop;

exit;
