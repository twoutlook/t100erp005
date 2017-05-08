/* 
================================================================================
檔案代號:dzdl_t
檔案名稱:應用元件組工作明細
檔案目的: 
上游檔案:
下游檔案:
檔案類型:X
多語系檔案:N
============.========================.==========================================
 */
create table dzdl_t
(
dzdlownid       varchar2(20)      ,/* 資料所有者 */
dzdlowndp       varchar2(10)      ,/* 資料所屬部門 */
dzdlcrtid       varchar2(20)      ,/* 資料建立者 */
dzdlcrtdp       varchar2(10)      ,/* 資料建立部門 */
dzdlcrtdt       timestamp(0)      ,/* 資料創建日 */
dzdlmodid       varchar2(20)      ,/* 資料修改者 */
dzdlmoddt       timestamp(0)      ,/* 最近修改日 */
dzdlcnfid       varchar2(20)      ,/* 資料確認者 */
dzdlcnfdt       timestamp(0)      ,/* 資料確認日 */
dzdlstus       varchar2(10)      ,/* 狀態碼 */
dzdl001       varchar2(20)      ,/* 4GL代號 */
dzdl002       varchar2(1)      ,/* 類型 */
dzdl003       varchar2(10)      ,/* 存放目錄 */
dzdl004       number(10,0)      ,/* 項次 */
dzdl005       varchar2(40)      ,/* 工作項代號 */
dzdl006       varchar2(20)      ,/* SA編號 */
dzdl007       varchar2(10)      ,/* SA狀態 */
dzdl008       varchar2(20)      ,/* SD編號 */
dzdl009       varchar2(10)      ,/* SD狀態 */
dzdl010       varchar2(20)      ,/* PR編號 */
dzdl011       varchar2(10)      ,/* PR狀態 */
dzdl012       varchar2(20)      ,/* 發佈人員編號 */
dzdl013       varchar2(10)      ,/* 發佈狀態 */
dzdl014       varchar2(255)      ,/* 備註 */
dzdl015       number(15,3)      ,/* 預留欄位1 */
dzdl016       number(15,3)      ,/* 預留欄位2 */
dzdl017       number(15,3)      ,/* 預留欄位3 */
dzdl018       number(15,3)      ,/* 預留欄位4 */
dzdl019       number(15,3)      ,/* 預留欄位5 */
dzdl020       varchar2(10)      ,/* 預留欄位6 */
dzdl021       varchar2(10)      ,/* 預留欄位7 */
dzdl022       varchar2(255)      /* 預留欄位8 */
);
alter table dzdl_t add constraint dzdl_pk primary key (dzdl001,dzdl004) enable validate;

create unique index dzdl_pk on dzdl_t (dzdl001,dzdl004);

grant select on dzdl_t to tiptop;
grant update on dzdl_t to tiptop;
grant delete on dzdl_t to tiptop;
grant insert on dzdl_t to tiptop;

exit;
