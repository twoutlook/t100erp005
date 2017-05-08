/* 
================================================================================
檔案代號:dzfi_t
檔案名稱:畫面結構檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table dzfi_t
(
dzfi001       varchar2(20)      ,/* 結構代號 */
dzfi002       number(10)      ,/* 規格版次 */
dzfi003       number(5,0)      ,/* 編號 */
dzfi004       varchar2(40)      ,/* 群組代碼 */
dzfi005       number(5,0)      ,/* 順序 */
dzfi006       varchar2(40)      ,/* 元件(組)代碼 */
dzfi007       varchar2(20)      ,/* 節點類型 */
dzfi008       varchar2(1)      ,/* 是否顯示於畫面結構 */
dzfi009       varchar2(1)      ,/* 客製 */
dzfi010       varchar2(1)      ,/* 包含元素類型 */
dzfi011       varchar2(1)      ,/* 直橫排列V/H */
dzfiownid       varchar2(20)      ,/* 資料所有者 */
dzfiowndp       varchar2(10)      ,/* 資料所屬部門 */
dzficrtid       varchar2(20)      ,/* 資料建立者 */
dzficrtdp       varchar2(10)      ,/* 資料建立部門 */
dzficrtdt       timestamp(0)      ,/* 資料創建日 */
dzfimodid       varchar2(20)      ,/* 資料修改者 */
dzfimoddt       timestamp(0)      ,/* 最近修改日 */
dzfistus       varchar2(10)      ,/* 狀態碼 */
dzfi012       number(5,0)      ,/* 節點階層 */
dzfi013       number(5,0)      ,/* 群組X軸位置 */
dzfi014       number(5,0)      ,/* 群組Y軸位置 */
dzfi015       number(5,0)      ,/* 群組寬度 */
dzfi016       number(5,0)      ,/* 群組高度 */
dzfi017       varchar2(40)      /* 客戶代號 */
);
alter table dzfi_t add constraint dzfi_pk primary key (dzfi001,dzfi002,dzfi003,dzfi009) enable validate;

create unique index dzfi_pk on dzfi_t (dzfi001,dzfi002,dzfi003,dzfi009);

grant select on dzfi_t to tiptop;
grant update on dzfi_t to tiptop;
grant delete on dzfi_t to tiptop;
grant insert on dzfi_t to tiptop;

exit;
