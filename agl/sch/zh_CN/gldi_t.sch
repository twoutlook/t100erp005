/* 
================================================================================
檔案代號:gldi_t
檔案名稱:合併報表股東權益歷史資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:S
多語系檔案:N
============.========================.==========================================
 */
create table gldi_t
(
gldient       number(5)      ,/* 企業編號 */
gldi001       varchar2(10)      ,/* 公司編號(下層) */
gldi002       varchar2(5)      ,/* 帳別/合併帳別(下層) */
gldi003       varchar2(10)      ,/* 公司編號(上層) */
gldi004       varchar2(5)      ,/* 合併帳別(上層) */
gldi005       varchar2(10)      ,/* 記帳幣別 */
gldi006       varchar2(10)      ,/* 功能幣別 */
gldi007       varchar2(10)      ,/* 報告幣別 */
gldi008       varchar2(10)      ,/* 核算項資料 */
gldi009       varchar2(24)      ,/* 來源科目編號 */
gldi010       varchar2(24)      ,/* 合併科目編號 */
gldi011       date      ,/* 異動日期 */
gldi012       number(20,6)      ,/* 借方金額(記帳幣) */
gldi013       number(20,6)      ,/* 貸方金額(記帳幣) */
gldi014       number(20,6)      ,/* 借方金額(功能幣) */
gldi015       number(20,6)      ,/* 貸方金額(功能幣) */
gldi016       number(20,6)      ,/* 借方金額(報告幣) */
gldi017       number(20,6)      ,/* 貸方金額(報告幣) */
gldiownid       varchar2(20)      ,/* 資料所有者 */
gldiowndp       varchar2(10)      ,/* 資料所屬部門 */
gldicrtid       varchar2(20)      ,/* 資料建立者 */
gldicrtdp       varchar2(10)      ,/* 資料建立部門 */
gldicrtdt       timestamp(0)      ,/* 資料創建日 */
gldimodid       varchar2(20)      ,/* 資料修改者 */
gldimoddt       timestamp(0)      ,/* 最近修改日 */
gldistus       varchar2(10)      /* 狀態碼 */
);
alter table gldi_t add constraint gldi_pk primary key (gldient,gldi001,gldi002,gldi003,gldi004,gldi008,gldi009,gldi010,gldi011) enable validate;

create unique index gldi_pk on gldi_t (gldient,gldi001,gldi002,gldi003,gldi004,gldi008,gldi009,gldi010,gldi011);

grant select on gldi_t to tiptop;
grant update on gldi_t to tiptop;
grant delete on gldi_t to tiptop;
grant insert on gldi_t to tiptop;

exit;
