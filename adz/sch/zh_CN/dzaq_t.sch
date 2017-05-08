/* 
================================================================================
檔案代號:dzaq_t
檔案名稱:行業程式同步紀錄表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table dzaq_t
(
dzaq001       varchar2(20)      ,/* 行業程式代號 */
dzaq002       number(5,0)      ,/* 需求單項次 */
dzaq003       varchar2(20)      ,/* 需求單號 */
dzaq004       number(10)      ,/* 行業建構版次 */
dzaq005       number(10)      ,/* 行業規格版次 */
dzaq006       number(10)      ,/* 行業程式版次 */
dzaq007       number(10)      ,/* 標準建構版次 */
dzaq008       number(10)      ,/* 標準規格版次 */
dzaq009       number(10)      ,/* 標準程式版次 */
dzaq010       varchar2(1)      ,/* 同步否 */
dzaq011       varchar2(80)      ,/* 行業代號 */
dzaq012       varchar2(20)      ,/* 標準程式代號 */
dzaqownid       varchar2(20)      ,/* 資料所有者 */
dzaqowndp       varchar2(10)      ,/* 資料所屬部門 */
dzaqcrtid       varchar2(20)      ,/* 資料建立者 */
dzaqcrtdp       varchar2(10)      ,/* 資料建立部門 */
dzaqcrtdt       timestamp(0)      ,/* 資料創建日 */
dzaqmodid       varchar2(20)      ,/* 資料修改者 */
dzaqmoddt       timestamp(0)      ,/* 最近修改日 */
dzaq013       varchar2(10)      /* 模組 */
);
alter table dzaq_t add constraint dzaq_pk primary key (dzaq001) enable validate;

create unique index dzaq_pk on dzaq_t (dzaq001);

grant select on dzaq_t to tiptop;
grant update on dzaq_t to tiptop;
grant delete on dzaq_t to tiptop;
grant insert on dzaq_t to tiptop;

exit;
