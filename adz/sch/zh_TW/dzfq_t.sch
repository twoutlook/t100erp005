/* 
================================================================================
檔案代號:dzfq_t
檔案名稱:畫面結構設計主檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table dzfq_t
(
dzfqstus       varchar2(10)      ,/* 狀態碼 */
dzfq001       varchar2(40)      ,/* 結構代號 */
dzfq002       varchar2(10)      ,/* (產品)版號 */
dzfq003       number(10)      ,/* 規格版次 */
dzfq004       varchar2(20)      ,/* 畫面代號 */
dzfq005       varchar2(1)      ,/* 主/子作業 */
dzfq006       varchar2(10)      ,/* 單頭資料 */
dzfq007       varchar2(20)      ,/* 單頭框架 */
dzfq008       number(5,0)      ,/* 換行數量 */
dzfq009       varchar2(20)      ,/* 單身切割框架 */
dzfq010       varchar2(20)      ,/* 單身框架 */
dzfq011       varchar2(10)      ,/* 單身狀態碼功能鍵區塊 */
dzfq012       varchar2(1)      ,/* 單身串查 */
dzfq013       varchar2(1)      ,/* 子程式進入模式 */
dzfq014       varchar2(1)      ,/* 空框架程式碼 */
dzfqownid       varchar2(20)      ,/* 資料所有者 */
dzfqowndp       varchar2(10)      ,/* 資料所屬部門 */
dzfqcrtid       varchar2(20)      ,/* 資料建立者 */
dzfqcrtdp       varchar2(10)      ,/* 資料建立部門 */
dzfqcrtdt       timestamp(0)      ,/* 資料創建日 */
dzfqmodid       varchar2(20)      ,/* 資料修改者 */
dzfqmoddt       timestamp(0)      ,/* 最近修改日 */
dzfq015       varchar2(1)      ,/* 空框架畫面檔 */
dzfq016       varchar2(10)      /* 樹狀結構類別 */
);
alter table dzfq_t add constraint dzfq_pk primary key (dzfq003,dzfq004) enable validate;

create unique index dzfq_pk on dzfq_t (dzfq003,dzfq004);

grant select on dzfq_t to tiptop;
grant update on dzfq_t to tiptop;
grant delete on dzfq_t to tiptop;
grant insert on dzfq_t to tiptop;

exit;
