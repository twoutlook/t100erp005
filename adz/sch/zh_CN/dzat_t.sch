/* 
================================================================================
檔案代號:dzat_t
檔案名稱:設計資料離線檔備份
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table dzat_t
(
dzat001       varchar2(20)      ,/* 程式代號 */
dzat002       number(10)      ,/* 版次 */
dzat003       varchar2(10)      ,/* 建構類型 */
dzat004       varchar2(10)      ,/* 簽出類型 */
dzat005       varchar2(20)      ,/* 需求單號 */
dzat006       number(5,0)      ,/* 需求單項次 */
dzat007       date      ,/* 簽出日期 */
dzat008       varchar2(10)      ,/* 模組 */
dzat009       blob      ,/* 離線檔案(tzs/tzc) */
dzat010       blob      ,/* 離線檔案(tzr) */
dzat011       varchar2(40)      ,/* no use */
dzat012       varchar2(40)      ,/* no use */
dzat013       varchar2(1)      ,/* 客製 */
dzatownid       varchar2(20)      ,/* 資料所有者 */
dzatowndp       varchar2(10)      ,/* 資料所屬部門 */
dzatcrtid       varchar2(20)      ,/* 資料建立者 */
dzatcrtdp       varchar2(10)      ,/* 資料建立部門 */
dzatcrtdt       timestamp(0)      ,/* 資料創建日 */
dzatmodid       varchar2(20)      ,/* 資料修改者 */
dzatmoddt       timestamp(0)      /* 最近修改日 */
);
alter table dzat_t add constraint dzat_pk primary key (dzat001,dzat002,dzat004,dzat013) enable validate;

create unique index dzat_pk on dzat_t (dzat001,dzat002,dzat004,dzat013);

grant select on dzat_t to tiptop;
grant update on dzat_t to tiptop;
grant delete on dzat_t to tiptop;
grant insert on dzat_t to tiptop;

exit;
