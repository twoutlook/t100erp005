/* 
================================================================================
檔案代號:dzit_t
檔案名稱:中介表格觸發器資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table dzit_t
(
dzit001       varchar2(15)      ,/* 表格名稱 */
dzit002       varchar2(20)      ,/* 觸發器ID */
dzit003       varchar2(20)      ,/* 欲建立觸發Schema */
dzit004       varchar2(10)      ,/* 標準或客製 */
dzit005       varchar2(10)      ,/* 觸發時機點 */
dzit006       varchar2(20)      ,/* 觸發事件 */
dzit007       varchar2(10)      ,/* 觸發方式 */
dzit008       clob      ,/* 觸發器Scripts */
dzit009       varchar2(1)      ,/* 觸發器狀態 */
dzitcrtid       varchar2(20)      ,/* 資料建立者 */
dzitcrtdt       timestamp(0)      ,/* 資料創建日 */
dzitmodid       varchar2(20)      ,/* 資料修改者 */
dzitmoddt       timestamp(0)      ,/* 最近修改日 */
dzit010       varchar2(1)      /* 出貨識別 */
);
alter table dzit_t add constraint dzit_pk primary key (dzit001,dzit002,dzit003,dzit004) enable validate;

create unique index dzit_pk on dzit_t (dzit001,dzit002,dzit003,dzit004);

grant select on dzit_t to tiptop;
grant update on dzit_t to tiptop;
grant delete on dzit_t to tiptop;
grant insert on dzit_t to tiptop;

exit;
